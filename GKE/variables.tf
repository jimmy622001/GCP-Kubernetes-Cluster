variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "d-nbi-mikai-d6c"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "europe-west1"

}

variable "zone" {
  description = "The GCP zone"
  type        = string
  default     = "europe-west1-b"

}

variable "vpc_name" {
  description = "The name of the existing VPC"
  type        = string
  default     = "d-nbi-mikai-d6c-vpc"

}

# variable "nat_ip" {
#   description = "The static IP address for the NAT gateway"
#   type        = string
#   default     = "null"
# }

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "xxxx-cluster"
}
variable "machine_type" {
  description = "The machine type for the GKE nodes"
  type        = string
  default     = "e2-standard-16"

}
variable "subnetwork" {
  type        = string
  description = "The name of the existing subnetwork"
  default     = "d-nbi-mikai-d6c-private-subnet"
}
variable "private_subnet" {
  type        = string
  description = "The name of the existing private subnet"
  default     = "d-nbi-mikai-d6c-private-subnet"
}

variable "public_subnet" {
  type        = string
  description = "The name of the existing public subnet"
  default     = "d-nbi-mikai-d6c-public-subnet"
}
# variable "min_node_count" {
#   description = "Minimum number of nodes in the node pool"
#   type        = number
#   default     = 1
# }
#
# variable "max_node_count" {
#   description = "Maximum number of nodes in the node pool"
#   type        = number
#   default     = 1
# }
variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}
variable "secret_name" {
  description = "The name of the secret in Secret Manager to use for the Terraform service account."
  type        = string
  default     = "xxxxxx"
}
