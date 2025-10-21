package models

import (
	"time"

	"gorm.io/gorm"
)

type Booking struct {
	ID           uint           `json:"id" gorm:"primaryKey"`
	UserID       uint           `json:"user_id"`
	User         User           `json:"user" gorm:"foreignKey:UserID"`
	ScheduleID   uint           `json:"schedule_id"`
	Schedule     Schedule       `json:"schedule" gorm:"foreignKey:ScheduleID"`
	BookingCode  string         `json:"booking_code" gorm:"uniqueIndex;not null"`
	Status       string         `json:"status" gorm:"default:pending"`
	TotalPrice   float64        `json:"total_price" gorm:"type:decimal(10,2)"`
	BookingSeats []BookingSeat  `json:"booking_seats" gorm:"foreignKey:BookingID"`
	Payments     []Payment      `json:"payments" gorm:"foreignKey:BookingID"`
	CreatedAt    time.Time      `json:"created_at"`
	UpdatedAt    time.Time      `json:"updated_at"`
	DeletedAt    gorm.DeletedAt `json:"-" gorm:"index"`
}

type BookingSeat struct {
	ID        uint           `json:"id" gorm:"primaryKey"`
	BookingID uint           `json:"booking_id"`
	Booking   Booking        `json:"booking" gorm:"foreignKey:BookingID"`
	SeatID    uint           `json:"seat_id"`
	Seat      Seat           `json:"seat" gorm:"foreignKey:SeatID"`
	Status    string         `json:"status" gorm:"default:reserved"`
	CreatedAt time.Time      `json:"created_at"`
	DeletedAt gorm.DeletedAt `json:"-" gorm:"index"`
}

type Payment struct {
	ID            uint           `json:"id" gorm:"primaryKey"`
	BookingID     uint           `json:"booking_id"`
	Booking       Booking        `json:"booking" gorm:"foreignKey:BookingID"`
	Amount        float64        `json:"amount" gorm:"type:decimal(10,2);not null"`
	PaymentMethod string         `json:"payment_method"`
	Status        string         `json:"status" gorm:"default:pending"`
	PaymentCode   string         `json:"payment_code" gorm:"uniqueIndex"`
	CreatedAt     time.Time      `json:"created_at"`
	UpdatedAt     time.Time      `json:"updated_at"`
	DeletedAt     gorm.DeletedAt `json:"-" gorm:"index"`
}
