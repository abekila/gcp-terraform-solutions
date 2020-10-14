
module "enable_services" {
  source     = "./modules/enable_services"
  project_id = var.project_id
  api_list   = var.api_list
}

module "kubernetes_cluster" {
  source           = "./modules/gke_cluster"
  project_id       = var.project_id
  gke_cluster_name = var.gke_cluster_name
  region           = var.region
  zone             = var.zone
  node_count       = var.node_count
  machine_type     = var.machine_type
  disk_size_gb     = var.disk_size_gb
}


module "consul_helm_deployment" {
  source                = "./modules/helm_deployment"
  project_id            = var.project_id
  cluster_name          = var.gke_cluster_name
  helmfile_path         = var.helmfile_path
  helmfile_content      = var.consul_helmfile_content
  values_paths          = var.values_paths
  values                = var.values
  environment_variables = var.environment_variables
}

module "vault_helm_deployment" {
  source                = "./modules/helm_deployment"
  project_id            = var.project_id
  cluster_name          = var.gke_cluster_name
  helmfile_path         = var.helmfile_path
  helmfile_content      = var.vault_helmfile_content
  values_paths          = var.values_paths
  values                = var.values
  environment_variables = var.environment_variables
}