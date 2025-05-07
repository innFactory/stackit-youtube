terraform {
  required_providers {
    stackit = {
      source  = "stackitcloud/stackit"
      version = "0.51.0"
    }
  }
}

provider "stackit" {
  default_region           = "eu01"
  service_account_key_path = var.service_account_key_path
  private_key_path         = var.private_key_path
}

resource "stackit_secretsmanager_instance" "my_secretsmanager_instance" {
  project_id = var.project_id
  name       = "example-instance"
}

resource "stackit_secretsmanager_user" "example" {
  project_id    = var.project_id
  instance_id   = stackit_secretsmanager_instance.my_secretsmanager_instance.instance_id
  description   = "Example user"
  write_enabled = true
}

provider "vault" {
  address          = "https://prod.sm.eu01.stackit.cloud"
  skip_child_token = true

  auth_login_userpass {
    username = stackit_secretsmanager_user.example.username
    password = stackit_secretsmanager_user.example.password
  }
}


resource "stackit_volume" "my_server_volume" {
  project_id        = var.project_id
  name              = "my-server-volume"
  availability_zone = "eu01-1"
  size              = 5
  source = {
    id   = "3fafe17d-173d-48b2-9961-308246069b16"
    type = "image"
  }
}

module "ssh_key" {
  source                     = "./ssh-key"
  project_id                 = var.project_id
  secretsmanager_instance_id = stackit_secretsmanager_instance.my_secretsmanager_instance.instance_id
}

resource "stackit_server" "my_server" {
  project_id = var.project_id
  name       = "my-server"
  boot_volume = {
    source_id   = stackit_volume.my_server_volume.volume_id
    source_type = "volume"
  }
  machine_type = "t1.1"
  keypair_name = module.ssh_key.keypair_name
}

module "network" {
  source     = "./network"
  project_id = var.project_id
  server_id  = stackit_server.my_server.server_id
}

