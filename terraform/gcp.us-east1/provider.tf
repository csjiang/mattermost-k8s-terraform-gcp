terraform {
  required_version = "~> 0.14"

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.52.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}


provider "kubernetes" {
  load_config_file = "false"

  host     = google_container_cluster.primary.endpoint

  client_certificate     = google_container_cluster.primary.master_auth.0.client_certificate
  client_key             = google_container_cluster.primary.master_auth.0.client_key
  cluster_ca_certificate = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
}