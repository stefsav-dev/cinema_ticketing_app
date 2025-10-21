package models

import (
	"time"

	"gorm.io/gorm"
)

type Seat struct {
	ID         uint           `json:"id" gorm:"primaryKey"`
	StudioID   uint           `json:"studio_id"`
	Studio     Studio         `json:"studio" gorm:"foreignKey:StudioID"`
	RowNumber  string         `json:"row_number" gorm:"not null"`
	SeatNumber int            `json:"seat_number" gorm:"not null"`
	SeatType   string         `json:"seat_type" gorm:"default:regular"`
	CreatedAt  time.Time      `json:"created_at"`
	DeletedAt  gorm.DeletedAt `json:"-" gorm:"index"`
}

type SeatStatus struct {
	Seat      Seat   `json:"seat"`
	Status    string `json:"status"`
	BookingID *uint  `json:"booking_id,omitempty"`
}
