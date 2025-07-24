package router

import (
	"server/handler"

	"github.com/gin-gonic/gin"
)

func SetupRouter(userHandler *handler.UserHandler) *gin.Engine {
	r := gin.Default()
	r.POST("/register", userHandler.CreateUser)
	r.POST("/login", userHandler.LoginUser)
	return r
}
