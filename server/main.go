package main

import (
	"log"
	"os"

	"server/database"
	"server/handler"
	"server/model"
	"server/router"
	"server/service"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Println("No .env file found, using system environment variables")
	}

	gin.SetMode(os.Getenv("APP_MODE"))

	mongoClient, err := database.NewMongoClient(
		os.Getenv("MONGO_URI"),
		os.Getenv("DB_NAME"),
	)

	if err != nil {
		log.Fatal(err)
	}

	userHandler := handler.NewUserHandler(
		service.NewUserService(
			model.NewMongoUserRepo(mongoClient.DB),
		),
	)

	r := router.SetupRouter(userHandler)
	log.Println("Server running on :8080")
	r.Run(":" + os.Getenv("PORT"))
}
