package connection

import (
	"SDUI_SERVICE/database"
	"log"
)

func CreateConnection() {
	database.PostgreSQLConnect(
		"postgres",
		"postgres",
		"127.0.0.1",
		"sdui_service",
		"5432",
		"disable",
		"Asia/Manila",
	)
	err := database.DBConn.AutoMigrate()

	if err != nil {
		log.Fatal(err.Error())
	}

}
