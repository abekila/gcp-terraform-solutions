terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

terraform {
  backend "gcs" {
    bucket = "tf-remote-state-bc"
    prefix = "terraform/state"
  }
}
