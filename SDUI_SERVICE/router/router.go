package router

import (
	"SDUI_SERVICE/database"

	"github.com/gofiber/fiber/v2"
	"gorm.io/gorm/clause"
)

func SetupPublicRoutes(app *fiber.App) {

	// Endpoints
	apiEndpoint := app.Group("/api")
	v1Endpoint := apiEndpoint.Group("/v1")

	// Health check endpoint
	v1Endpoint.Get("/", func(c *fiber.Ctx) error {
		return c.JSON("health")
	})

	// Health check endpoint
	v1Endpoint.Get("/getRequiredFields", func(c *fiber.Ctx) error {
		result := []map[string]interface{}{}
		sql := "SELECT * FROM required_fields"
		queryErr := database.DBConn.Preload(clause.Associations).Raw(sql).Scan(&result).Error
		if queryErr != nil {
			return c.JSON("DATABASE ERROR!")
		}
		return c.JSON(result)
	})
}
