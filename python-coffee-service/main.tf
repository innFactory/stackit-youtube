terraform {
  required_providers {
    stackit = {
      source  = "stackitcloud/stackit"
      version = "0.53.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "stackit" {
  default_region           = "eu01"
  service_account_key_path = var.service_account_key_path
  private_key_path         = var.private_key_path
}


module "image-bucket" {
  source     = "./coffee-image-bucket"
  project_id = var.project_id
}
