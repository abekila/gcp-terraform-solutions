terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

terraform {
  backend "gcs" {
    bucket = "tf-remote-state_bc"
    prefix = "terraform/state"
  }
}


provider "google" {
  version = "3.5.0"
  project = "pacific-cab-287914"
  region  = "us-central1"
  zone    = "us-central1-c"
}


resource "google_storage_bucket" "image-store" {
  name     = "image-store-bucket"
  location = "EU"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

