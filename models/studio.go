package models

import (
	"time"

	"gorm.io/gorm"
)

type Studio struct {
	ID        uint           `json:"id" gorm:"primaryKey"`
	CinemaID  uint           `json:"cinema_id"`
	Cinema    Cinema         `json:"cinema" gorm:"foreignKey:CinemaID"`
	Name      string         `json:"name" gorm:"not null"`
	Capacity  int            `json:"capacity" gorm:"not null"`
	Seats     []Seat         `json:"seats" gorm:"foreignKey:StudioID"`
	CreatedAt time.Time      `json:"created_at"`
	DeletedAt gorm.DeletedAt `json:"-" gorm:"index"`
}
