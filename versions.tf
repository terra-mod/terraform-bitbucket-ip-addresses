terraform {
  required_version = ">= 0.12"
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = ">= 2.2.0, < 4.0.0"
    }
  }
}
