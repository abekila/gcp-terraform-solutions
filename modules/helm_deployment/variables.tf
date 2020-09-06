variable "project_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "helmfile_path" {
  default = null
  type    = string
}

variable "helmfile_content" {
  type    = map(any)
  default = null
  validation {
    condition     = can(yamlencode(var.helmfile_content))
    error_message = "Variable 'helmfile_content' value needs to be serializable to yaml."
  }
}

variable "values_paths" {
  type    = list(string)
  default = null
}

variable "values" {
  type    = map(any)
  default = null
  validation {
    condition     = can(yamlencode(var.values))
    error_message = "Variable 'values' value needs to be serializable to yaml."
  }
}

variable "environment_variables" {
  type    = map(string)
  default = {}
}
