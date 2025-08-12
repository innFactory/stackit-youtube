terraform {
  required_providers {
    stackit = {
      source  = "stackitcloud/stackit"
      version = "0.59.0"
    }
  }
}

provider "stackit" {
  default_region           = "eu01"
  service_account_key_path = var.service_account_key_path
  private_key_path         = var.private_key_path
}

resource "stackit_mongodbflex_instance" "mongo_terraform_instance" {
  project_id = var.project_id
  name       = "mongo-terraform-instance"
  acl        = ["0.0.0.0/0"] // do not allow public access in prod
  flavor = {
    cpu = 1
    ram = 4
  }
  replicas = 3
  storage = {
    class = "premium-perf2-mongodb"
    size  = 10
  }
  version = "8.0"
  options = {
    type                       = "Replica"
    snapshot_retention_days    = 3
    point_in_time_window_hours = 30
  }
  backup_schedule = "0 0 * * *"
}

resource "stackit_postgresflex_instance" "pg_terraform_instance" {
  project_id      = var.project_id
  name            = "pg-terraform-instance"
  acl             = ["0.0.0.0/0"] // do not allow public access in prod
  backup_schedule = "00 00 * * *"
  flavor = {
    cpu = 2
    ram = 4
  }
  replicas = 1
  storage = {
    class = "premium-perf6-stackit"
    size  = 5
  }
  version = 17
}
