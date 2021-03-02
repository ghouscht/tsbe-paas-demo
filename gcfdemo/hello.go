package gcfdemo

import (
	"encoding/json"
	"fmt"
	"html"
	"log"
	"net/http"
)

// HelloTSBE is an HTTP Cloud Function with a request parameter.
func HelloTSBE(w http.ResponseWriter, r *http.Request) {
	log.Println("HelloTSBE start")

	var d struct {
		Name string `json:"name"`
	}
	if err := json.NewDecoder(r.Body).Decode(&d); err != nil {
		fmt.Fprint(w, "Hello, TSBE students!")
		return
	}
	if d.Name == "" {
		fmt.Fprint(w, "Hello, TSBE students!")
		return
	}
	fmt.Fprintf(w, "Hello, TSBE student %s!", html.EscapeString(d.Name))

	log.Println("HelloTSBE stop")
}
