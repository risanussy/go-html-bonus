package main

import (
	"log"
	"net/http"
	"time"

	"bonus/controllers"
	"bonus/models"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

func main() {
	router := gin.Default()

	// Middleware CORS
	router.Use(cors.New(cors.Config{
		AllowOrigins:     []string{"*"},
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Authorization"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
		MaxAge:           12 * time.Hour,
	}))

	// Koneksi ke DB MySQL
	dsn := "root@tcp(127.0.0.1:3306)/order_bonus_api?charset=utf8mb4&parseTime=True&loc=Local"
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Gagal koneksi ke database: ", err)
	}

	// Migrasi model
	db.AutoMigrate(&models.Employee{}, &models.KPI{}, &models.Criterion{}, &models.Evaluation{}, &models.KPIEvaluation{},)

	// Set DB di controllers
	controllers.SetDB(db)

	api := router.Group("/api")
	{
		// Login (auth)
		api.POST("/login", controllers.Login)

		// KPI
		api.GET("/kpis", controllers.GetKPIs)
		api.POST("/kpis", controllers.CreateKPI)
		api.PUT("/kpis/:id", controllers.UpdateKPI)
		api.DELETE("/kpis/:id", controllers.DeleteKPI)

		api.POST("/kpi_evaluations", controllers.CreateKPIEvaluation)

		// Employee
		api.GET("/employees", controllers.GetEmployees)
		api.POST("/employees", controllers.CreateEmployee)
		api.PUT("/employees/:id", controllers.UpdateEmployee)
		api.DELETE("/employees/:id", controllers.DeleteEmployee)

		// Bonus
		api.POST("/bonus/calculate", controllers.CalculateBonus)
		api.GET("/bonus", controllers.GetBonus)
	}

	// Jalankan server di port 8080
	http.ListenAndServe(":8080", router)
}
