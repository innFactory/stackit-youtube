terraform {
  required_providers {
    stackit = {
      source  = "stackitcloud/stackit"
      version = "0.54.0"
    }
  }
}

provider "stackit" {
  default_region           = "eu01"
  service_account_key_path = var.service_account_key_path
  private_key_path         = var.private_key_path
}


terraform {
  backend "s3" {
    endpoints = {
      s3 = "https://object.storage.eu01.onstackit.cloud"
    }
    region = "eu01"
    # Also use remote locking
    use_lockfile = true
    # AWS specific checks must be skipped as they do not work on STACKIT.
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_s3_checksum            = true
    skip_requesting_account_id  = true
  }
}


