variable "api_list" {
  type = list
}
variable "project_id" {}

resource "google_project_service" "enable_gcp_services" {
  for_each = toset(var.api_list)
  project  = var.project_id
  service  = "${each.value}.googleapis.com"
}