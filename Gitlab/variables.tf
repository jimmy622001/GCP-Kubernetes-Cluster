variable "project_id" {
  description = "The GCP project ID"
}

variable "region" {
  description = "The GCP region"
}

variable "zone" {
  description = "The GCP zone"
}

variable "vpc_name" {
  description = "The name of the existing VPC"
  type        = string
}

variable "gitlab_instance_name" {
  description = "The name of the GitLab instance"
  type        = string
}

variable "machine_type" {
  description = "The machine type for the GitLab instance"
  type        = string
}

variable "private_subnet" {
  type        = string
  description = "The name of the existing private subnet"
}

variable "ssh_allowed_ips" {
  type        = list(string)
  description = "List of IP ranges allowed to SSH into the instance"
  default     = ["0.0.0.0/0"] # Adjust to restrict SSH access to specific developer IP ranges
}

variable "gitlab_disk_size" {
  description = "The size of the GitLab persistent disk (in GB)"
  type        = number
}
variable "ssh_public_key" {
  description = "The SSH public key for accessing the instance"
  type        = string
}