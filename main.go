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
	router := bunrouter.New()
	start = time.Now()

	router.GET("/", indexHandler)
	log.Printf("listening on http://localhost:%d\n", PORT)
	log.Println(http.ListenAndServe(fmt.Sprintf(":%d", PORT), router))
}

func indexHandler(w http.ResponseWriter, req bunrouter.Request) error {
	return bunrouter.JSON(w,
		bunrouter.H{
			"status": "alive",
			"uptime": time.Since(start).Truncate(time.Second).String(),
		},
	)
}
