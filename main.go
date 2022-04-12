package main

import (
	"strconv"

	"github.com/gin-gonic/gin"
)

func main() {
	var users []gin.H

	r := gin.Default()
	r.GET("/users", func(c *gin.Context) {
		c.JSON(200, users)
	})

	r.GET("/users/:id", func(c *gin.Context) {
		id, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			c.JSON(400, gin.H{"error": "invalid id"})
		} else {
			c.JSON(200, users[id])
		}
	})

	r.POST("/users/:name", func(c *gin.Context) {
		name := c.Param("name")
		users = append(users, gin.H{"id": len(users), "name": name})
		c.JSON(200, users)
	})

	r.PUT("/users/:id/:name", func(c *gin.Context) {
		newName := c.Param("name")
		id, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			c.JSON(400, gin.H{"error": "invalid id"})
		} else {
			users[id] = gin.H{"id": id, "name": newName}
			c.JSON(200, users[id])
		}
	})

	r.DELETE("/users/:id", func(c *gin.Context) {
		id, err := strconv.Atoi(c.Param("id"))
		if err != nil {
			c.JSON(400, gin.H{"error": "invalid id"})
		} else {
			users = append(users[:id], users[id+1:]...)
			c.JSON(200, users)
		}
	})

	r.Run()
}
