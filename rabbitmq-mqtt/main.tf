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

resource "stackit_rabbitmq_instance" "example" {
  project_id = var.project_id
  name       = "example-instance"
  version    = "4.1"
  plan_name  = "stackit-rabbitmq-2.4.10-single"
  parameters = {
    sgw_acl           = "0.0.0.0/0" # Don't use this for Prod: allow all IPs to access the instance
    consumer_timeout  = 18000000
    enable_monitoring = false
    plugins           = ["rabbitmq_mqtt"]
  }
}

resource "stackit_rabbitmq_credential" "example" {
  project_id  = var.project_id
  instance_id = stackit_rabbitmq_instance.example.instance_id
}