package models

import "time"

type Schedule struct {
	ID        uint      `json:"id" gorm:"primaryKey"`
	MovieID   uint      `json:"movie_id"`
	Movie     Movie     `json:"movie" gorm:"foreignKey:MovieID"`
	StudioID  uint      `json:"studio_id"`
	Studio    Studio    `json:"studio" gorm:"foreignKey:StudioID"`
	ShowTime  time.Time `json:"show_time"`
	Price     float64   `json:"price" gorm:"type:decimal(10,2)"`
	CreatedAt time.Time `json:"created_at"`
}

type Movie struct {
	ID          uint      `json:"id" gorm:"primaryKey"`
	Title       string    `json:"title" gorm:"not null"`
	Duration    string    `json:"duration"`
	Genre       string    `json:"genre"`
	Description string    `json:"description"`
	CreatedAt   time.Time `json:"created_at"`
}

type Cinema struct {
	ID      uint   `json:"id" gorm:"primaryKey"`
	CityID  uint   `json:"city_id"`
	City    City   `json:"city" gorm:"foreignKey:CityID"`
	Name    string `json:"name" gorm:"not null"`
	Address string `json:"address"`
}

type City struct {
	ID   uint   `json:"id" gorm:"primaryKey"`
	Name string `json:"name" gorm:"not null"`
}
