package main

import (
	"cinema-ticket-system/config"
	"cinema-ticket-system/handlers"
	"cinema-ticket-system/middleware"
	"log"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Println("No .env file found")
	}

	config.InitDB()
	defer config.CloseDB()

	r := gin.Default()

	auth := r.Group("/auth")
	{
		auth.POST("/register", handlers.Register)
		auth.POST("/login", handlers.Login)
	}

	protected := r.Group("/api")
	protected.Use(middleware.AuthMiddleware())
	{
		protected.GET("/profile", handlers.GetProfile)

		schedules := protected.Group("/schedules")
		{
			schedules.GET("/", handlers.GetSchedules)
			schedules.GET("/:id", handlers.GetSchedule)
			schedules.POST("/", handlers.CreateSchedule)
			schedules.PUT("/:id", handlers.UpdateSchedule)
			schedules.DELETE("/:id", handlers.DeleteSchedule)
		}
		
		bookings := protected.Group("/bookings")
		{
			bookings.POST("/", handlers.CreateBooking)
			bookings.GET("/seats/:schedule_id", handlers.GetAvailableSeats)
		}
	}

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	log.Printf("Server running on port %s", port)
	r.Run(":" + port)
}
