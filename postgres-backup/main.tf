terraform {
  required_providers {
    stackit = {
      source  = "stackitcloud/stackit"
      version = "0.80.0"
    }
  }
}

provider "stackit" {
  default_region           = "eu01"
  service_account_key_path = var.service_account_key_path
  private_key_path         = var.private_key_path
}




