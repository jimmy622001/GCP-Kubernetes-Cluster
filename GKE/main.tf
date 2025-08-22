# Create the GKE cluster
resource "google_container_cluster" "gke_cluster" {
  name                     = var.cluster_name
  project                  = var.project_id
  location                 = var.zone
  network                  = var.vpc_name
  subnetwork               = var.private_subnet
  deletion_protection      = false
  min_master_version       = "1.30"
  remove_default_node_pool = true
  initial_node_count       = 1

  #  cluster_autoscaling {
  #    enabled = true
  #    resource_limits {
  #      resource_type = "cpu"
  #      minimum       = 4
  #      maximum       = 16
  #    }
  #    resource_limits {
  #      resource_type = "memory"
  #      minimum       = 16
  #      maximum       = 64
  #    }
  #  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.0/8"
      display_name = "internal"
    }
    cidr_blocks {
      cidr_block   = "79.130.122.78/32" # Your current IP
      display_name = "my-ip"
    }
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

resource "kubernetes_namespace" "my_node_pool" {
  metadata {
    name = "my-node-pool"
    labels = {
      name = "my-node-pool"
    }
  }

  depends_on = [google_container_cluster.gke_cluster]
}

resource "kubernetes_resource_quota" "my_node_pool" {
  metadata {
    name      = "my-node-pool-quota"
    namespace = kubernetes_namespace.my_node_pool.metadata[0].name
  }

  spec {
    hard = {
      "requests.cpu"    = "32"
      "requests.memory" = "24Gi"
      "limits.cpu"      = "96"
      "limits.memory"   = "128Gi"
    }
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name     = "my-node-pool"
  location = var.zone
  cluster  = google_container_cluster.gke_cluster.name

  # autoscaling {
  #   min_node_count = var.min_node_count
  #   max_node_count = var.max_node_count

  node_config {
    machine_type = var.machine_type
    labels = {
      "node-pool" = "my-node-pool"
    }
    disk_size_gb    = 50
    preemptible     = true
    service_account = "terraform@d-nbi-mikai-d6c.iam.gserviceaccount.com"
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }
}

# resource "kubernetes_horizontal_pod_autoscaler_v2" "my_app_hpa" {
#  metadata {
#    name      = "my-app-hpa"
#    namespace = "my-node-pool"
#  }
#
#  spec {
#    scale_target_ref {
#      api_version = "apps/v1"
#      kind        = "Deployment"
#      name        = "mkai-frontend"
#    }
#
#    min_replicas = 1
#    max_replicas = 1
#
#    metric {
#      type = "Resource"
#      resource {
#        name = "cpu"
#        target {
#          type                = "Utilization"
#          average_utilization = 50
#        }
#      }
#    }
#
#    metric {
#      type = "Resource"
#      resource {
#        name = "memory"
#        target {
#          type                = "Utilization"
#          average_utilization = 70
#        }
#      }
#    }
#  }
#}

# resource "kubernetes_service" "mkai_frontend" {
#   metadata {
#     name      = "mkai-frontend"
#     namespace = "my-node-pool"
#     annotations = {
#       "cloud.google.com/neg" = "{\"ingress\":true}"
#     }
#   }

#   spec {
#     selector = {
#       app = "mkai-frontend"
#     }

#     port {
#       port        = 80
#       target_port = 4200  
#     }

#     type = "LoadBalancer"
#   }

#   wait_for_load_balancer = true
# }

# Output for kubeconfig
output "kubeconfig" {
  value = {
    cluster_name           = google_container_cluster.gke_cluster.name
    endpoint               = google_container_cluster.gke_cluster.endpoint
    client_certificate     = base64decode(google_container_cluster.gke_cluster.master_auth[0].client_certificate)
    client_key             = base64decode(google_container_cluster.gke_cluster.master_auth[0].client_key)
    cluster_ca_certificate = base64decode(google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate)
    token                  = data.google_client_config.default.access_token
  }
  sensitive = true
}
