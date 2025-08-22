terraform {
  backend "gcs" {
    bucket = "xxxx"
    prefix = "GKE/state"

  }
}