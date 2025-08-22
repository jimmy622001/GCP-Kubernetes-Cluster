terraform {
  backend "gcs" {
    bucket = "mkai"
    prefix = "gitlab/state"

  }
}