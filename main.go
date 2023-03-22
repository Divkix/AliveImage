package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"strconv"
	"time"

	"github.com/uptrace/bunrouter"
)

var start time.Time

func main() {
	// Use the log package's default logger
	log.SetFlags(log.LstdFlags | log.Lmicroseconds)

	// Get the port from the environment variable or default to 8080
	port, err := strconv.Atoi(os.Getenv("PORT"))
	if err != nil {
		port = 8080
	}

	// Create a new bunrouter
	router := bunrouter.New()

	// Add a route for the index
	router.GET("/", indexHandler)

	// Start the server
	log.Printf("Listening on :%d\n", port)

	// Use http.ListenAndServe() directly instead of logging the return value
	if err := http.ListenAndServe(fmt.Sprintf(":%d", port), router); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}

// indexHandler is the handler for the index route
func indexHandler(w http.ResponseWriter, req bunrouter.Request) error {
	// Set the content type to JSON
	w.Header().Set("Content-Type", "application/json")

	// Return a JSON response with the status and uptime, truncated to seconds
	return bunrouter.JSON(w,
		bunrouter.H{
			"status":   "alive",
			"uptime":   time.Since(start).Truncate(time.Second).String(),
			"hostname": os.Getenv("HOSTNAME"),
		},
	)
}
