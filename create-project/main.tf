terraform {
    required_providers {
    stackit = {
      source = "stackitcloud/stackit"
      version = "0.50.0"
    }
  }
}

provider "stackit" {
  default_region           = "eu01"
  service_account_key_path = var.service_account_key_path
  private_key_path         = var.private_key_path
}

resource "stackit_resourcemanager_project" "terraform-test" {
  name                = "terraform-test"
  parent_container_id = "<<uuid-of-your-organization>>"
  owner_email         = "<<email-of-an-organization-owner>>"
}