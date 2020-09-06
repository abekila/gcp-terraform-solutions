variable "helmfile_path" {
  type    = string
  default = null

}

variable "consul_helmfile_content" {}

variable "vault_helmfile_content" {}

variable "values_paths" {
  type    = list(string)
  default = null
}
variable "values" {
  type    = map(any)
  default = null
}
variable "environment_variables" {}
variable "gke_cluster_name" {}
variable "node_count" {}
variable "auto_upgrade" {}
variable "machine_type" {}
variable "disk_size_gb" {}
variable "project_id" {}
variable "zone" {}
variable "region" {}

variable "api_list" {}