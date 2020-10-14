# Get latest cluster version
data "google_container_engine_versions" "versions" {
  project  = var.project_id
  location = var.zone
}

resource "google_container_cluster" "k8s_deploy" {
  provider = google-beta
  name     = var.gke_cluster_name
  location = var.zone
  project  = var.project_id

  enable_shielded_nodes = true

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = var.node_count

  min_master_version = data.google_container_engine_versions.versions.latest_master_version
  node_version       = data.google_container_engine_versions.versions.latest_master_version


  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }

  # Configure various addons
  addons_config {

    # Enable network policy configurations (like Calico).
    network_policy_config {
      disabled = true
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name     = "${var.gke_cluster_name}-preemptible-node"
  location = var.zone
  cluster  = google_container_cluster.k8s_deploy.name
  version  = data.google_container_engine_versions.versions.latest_master_version
  initial_node_count = var.node_count

  autoscaling {
    min_node_count = var.node_count
    max_node_count = var.node_count
  }

  management {
    auto_repair  = true
  }

  node_config {
    preemptible  = true
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/cloudkms",
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
