package main

import (
	"encoding/json"
	"fmt"
	"html"
	"log"
	"net/http"
	"os"
)

func main() {
	hn, err := os.Hostname()
	if err != nil {
		log.Fatal(err)
	}

	if err := http.ListenAndServe(":8080", HelloTSBE(hn)); err != nil {
		log.Fatal(err)
	}
}

func HelloTSBE(hn string) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		//log.Println("HelloTSBE start")

		var d struct {
			Name string `json:"name"`
		}
		if err := json.NewDecoder(r.Body).Decode(&d); err != nil {
			fmt.Fprintf(w, "Hello, TSBE students form %s!", hn)
			return
		}
		if d.Name == "" {
			fmt.Fprint(w, "Hello, TSBE students from %s!", hn)
			return
		}
		fmt.Fprintf(w, "Hello, TSBE student %s from %s!", html.EscapeString(d.Name), hn)

		//log.Println("HelloTSBE stop")
	}
}
