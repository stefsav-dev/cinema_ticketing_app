package handlers

import (
	"cinema-ticket-system/config"
	"cinema-ticket-system/models"
	"fmt"
	"math/rand"
	"net/http"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type CreateBookingRequest struct {
	ScheduleID uint   `json:"schedule_id" binding:"required"`
	SeatIDs    []uint `json:"seat_ids" binding:"required"`
}

type BookingResponse struct {
	Booking    models.Booking `json:"booking"`
	Seats      []models.Seat  `json:"seats"`
	TotalPrice float64        `json:"total_price"`
}

func CreateBooking(c *gin.Context) {
	var req CreateBookingRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	userIDInterface, exists := c.Get("user_id")
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "User not authenticated"})
		return
	}

	userID := uint(userIDInterface.(float64))

	var schedule models.Schedule
	if err := config.DB.First(&schedule, req.ScheduleID).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Schedule not found"})
		return
	}

	err := config.DB.Transaction(func(tx *gorm.DB) error {

		var existingBookings []models.BookingSeat
		if err := tx.Joins("JOIN bookings ON booking_seats.booking_id = bookings.id").
			Where("booking_seats.seat_id IN ? AND bookings.schedule_id = ? AND booking_seats.status IN ?",
				req.SeatIDs, req.ScheduleID, []string{"reserved", "booked"}).
			Find(&existingBookings).Error; err != nil {
			return err
		}

		if len(existingBookings) > 0 {
			return fmt.Errorf("some seats are already booked")
		}

		var seats []models.Seat
		if err := tx.Where("id IN ? AND studio_id = ?", req.SeatIDs, schedule.StudioID).Find(&seats).Error; err != nil {
			return err
		}

		if len(seats) != len(req.SeatIDs) {
			return fmt.Errorf("some seats not found or don't belong to this studio")
		}

		totalPrice := schedule.Price * float64(len(seats))

		booking := models.Booking{
			UserID:      userID,
			ScheduleID:  req.ScheduleID,
			BookingCode: generateBookingCode(),
			Status:      "pending",
			TotalPrice:  totalPrice,
		}

		if err := tx.Create(&booking).Error; err != nil {
			return err
		}

		for _, seat := range seats {
			bookingSeat := models.BookingSeat{
				BookingID: booking.ID,
				SeatID:    seat.ID,
				Status:    "reserved",
			}
			if err := tx.Create(&bookingSeat).Error; err != nil {
				return err
			}
		}

		return nil
	})

	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{
		"message":      "Booking created successfully",
		"booking_code": generateBookingCode(),
	})
}

func GetAvailableSeats(c *gin.Context) {
	scheduleID, err := strconv.Atoi(c.Param("schedule_id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid schedule ID"})
		return
	}

	var schedule models.Schedule
	if err := config.DB.
		Preload("Studio").
		Preload("Studio.Seats").
		First(&schedule, scheduleID).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Schedule not found"})
		return
	}

	var bookedSeats []models.BookingSeat
	if err := config.DB.
		Joins("JOIN bookings ON booking_seats.booking_id = bookings.id").
		Where("bookings.schedule_id = ? AND booking_seats.status IN ?",
			scheduleID, []string{"reserved", "booked"}).
		Find(&bookedSeats).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to get seat availability"})
		return
	}

	bookedSeatIDs := make(map[uint]bool)
	for _, bs := range bookedSeats {
		bookedSeatIDs[bs.SeatID] = true
	}

	var seatStatus []models.SeatStatus
	for _, seat := range schedule.Studio.Seats {
		status := "available"
		if bookedSeatIDs[seat.ID] {
			status = "booked"
		}

		seatStatus = append(seatStatus, models.SeatStatus{
			Seat:   seat,
			Status: status,
		})
	}

	c.JSON(http.StatusOK, gin.H{
		"schedule_id": scheduleID,
		"studio":      schedule.Studio.Name,
		"seats":       seatStatus,
	})
}

func generateBookingCode() string {
	rand.New(rand.NewSource(time.Now().UnixNano()))
	letters := "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	b := make([]byte, 8)
	for i := range b {
		b[i] = letters[rand.Intn(len(letters))]
	}
	return string(b)
}
