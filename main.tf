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

provider "google" {
  version = "3.5.0"
  project = "bks-infra"
  region  = "us-central1"
  zone    = "us-central1-c"
}
