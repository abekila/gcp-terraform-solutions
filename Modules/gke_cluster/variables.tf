variable "gke_cluster_name" {
  type = string
}

variable "zone" {
  type = string
}


variable "node_count" {
  type    = number
}

variable "project_id" {
  type = string
}

variable "channel" {
  type    = string
  default = "STABLE"
}

variable "auto_upgrade" {
  type = bool
}

variable "machine_type" {
  type = string
}

variable "disk_size_gb" {
  type = string
}

variable "region" {
    type = string
}