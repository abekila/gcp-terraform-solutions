terraform {
  required_providers {
    helmfile = {
      source  = "mumoshu/helmfile"
      version = "0.3.14"
    }
  }
}

resource "helmfile_release_set" "helmfile_release" {
  environment = "default"

  environment_variables = merge(
    var.environment_variables,
    {

    }
  )

  path    = var.helmfile_path
  content = var.helmfile_content == null ? null : jsonencode(var.helmfile_content)

  values = compact([
    var.values == null ? "" : jsonencode(var.values)
  ])

  values_files = var.values_paths
}

output "helmfile_diff" {
  value = helmfile_release_set.helmfile_release.diff_output
}

output "helmfile_apply" {
  value = helmfile_release_set.helmfile_release.apply_output
}
