provider "google" {
 credentials = file("TSBE.json")
 project     = "tsbe-306406"
 region      = "europe-west6"
}