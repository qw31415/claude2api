package main

import (
	"claude2api/config"
	"claude2api/router"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	// Load configuration

	// Setup all routes
	router.SetupRoutes(r)

	// Run the server on 0.0.0.0:10000
	r.Run(config.ConfigInstance.Address)
}

// main.go
package main

import (
  "os"
  "github.com/gin-gonic/gin"
)

func main() {
  r := gin.Default()
  // 读取 Render 自动注入的端口
  port := os.Getenv("PORT")
  if port == "" {
    port = "8080"  // 本地开发时的兜底值
  }
  r.GET("/", func(c *gin.Context) {
    c.String(200, "hello render")
  })
  r.Run(":" + port)
}

