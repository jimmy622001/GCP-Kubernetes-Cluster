provider "google" {
  project = var.project_id
  region  = var.region
}

# Data source to find the existing VPC
data "google_compute_network" "existing_vpc" {
  name = var.vpc_name
}

# Data source to find the existing subnet
data "google_compute_subnetwork" "existing_subnet" {
  name   = var.private_subnet
  region = var.region
}

# Create a static IP address
resource "google_compute_address" "gitlab_static_ip" {
  name   = "gitlab-static-ip"
  region = var.region
}

resource "google_compute_firewall" "gitlab_firewall" {
  name    = "gitlab-firewall"
  network = data.google_compute_network.existing_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"] # HTTP, HTTPS, SSH
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "gitlab_instance" {
  name         = var.gitlab_instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-jammy-v20240927"
      size  = var.gitlab_disk_size
    }
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.existing_subnet.id
    access_config {
      nat_ip = google_compute_address.gitlab_static_ip.address // Use the static IP
    }
  }

  metadata = {
    ssh-keys = var.ssh_public_key
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y curl openssh-server ca-certificates
    curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
    EXTERNAL_URL="http://$(curl -s ifconfig.me)" apt-get install -y gitlab-ce
    sudo gitlab-ctl reconfigure
  EOT

  tags                = ["gitlab"]
  deletion_protection = "false" // Enable deletion protection
}

output "external_ip" {
  value = google_compute_address.gitlab_static_ip.address // Output the static IP
}