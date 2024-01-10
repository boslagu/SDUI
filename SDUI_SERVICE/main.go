package main

import (
	"SDUI_SERVICE/connection"
	"SDUI_SERVICE/router"
	"log"

	"github.com/gofiber/fiber/v2"

	"github.com/gofiber/fiber/v2/middleware/cors"
	"github.com/gofiber/fiber/v2/middleware/logger"
	"github.com/gofiber/fiber/v2/middleware/recover"
)

func main() {

	connection.CreateConnection()

	// Declare & initialize fiber
	app := fiber.New(fiber.Config{
		UnescapePath: true,
	})
	app.Use(recover.New())

	// Configure application CORS
	app.Use(cors.New(cors.Config{
		AllowOrigins: "*",
		AllowHeaders: "Origin, Content-Type, Accept, Authorization",
	}))

	app.Use(logger.New())

	// Use endpoints
	router.SetupPublicRoutes(app)

	// Run application
	err := app.Listen("192.168.0.26:8000")
	if err != nil {
		log.Fatal(err.Error())
	}
}
