provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_secret_manager_secret_version" "terraform_svc_acc" {
  secret   = var.secret_name
  provider = google-beta
}

output "service_account" {
  value     = data.google_secret_manager_secret_version.terraform_svc_acc.secret_data
  sensitive = true
}