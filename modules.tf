variable "project_id" { }
variable "gke_cluster_name" { }
variable "zone" { }
variable "node_count" { }
variable "auto_upgrade" { }
variable "machine_type" { }
variable "disk_size_gb" { }
variable "region" {}

module "kubernetes_cluster" {
  source                = "./modules/gke_cluster"
  project_id            = var.project_id
  gke_cluster_name      = var.gke_cluster_name
  region                = var.region
  zone                  = var.zone
  node_count            = var.node_count
  auto_upgrade          = var.auto_upgrade
  machine_type          = var.machine_type
  disk_size_gb          = var.disk_size_gb
}


