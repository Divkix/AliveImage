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

// start is the time when the server started
var start time.Time

// PORT is the port the server is listening on
var PORT int = func() int {
	port := os.Getenv("PORT")
	if port == "" {
		return 80
	}
	// convert string to int
	returnPort, _ := strconv.Atoi(port)
	return returnPort
}()

func main() {
	// set the time when the server started
	start = time.Now()
	// create a new bunrouter
	router := bunrouter.New()

	// add a route for the index
	router.GET("/", indexHandler)

	// start the server
	log.Printf("listening on http://localhost:%d\n", PORT)

	// listen and serve
	log.Println(http.ListenAndServe(fmt.Sprintf(":%d", PORT), router))
}

// indexHandler is the handler for the index route
func indexHandler(w http.ResponseWriter, req bunrouter.Request) error {
	// return a JSON response with the status and uptime, truncated to seconds
	return bunrouter.JSON(w,
		bunrouter.H{
			"status": "alive",
			"uptime": time.Since(start).Truncate(time.Second).String(),
		},
	)
}
