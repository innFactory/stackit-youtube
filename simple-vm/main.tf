terraform {
  required_providers {
    stackit = {
      source  = "stackitcloud/stackit"
      version = "0.50.0"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
}

provider "stackit" {
  default_region           = "eu01"
  service_account_key_path = var.service_account_key_path
  private_key_path         = var.private_key_path
}


resource "stackit_volume" "web_server_volume" {
  project_id        = var.project_id
  name              = "web-server-volume"
  availability_zone = "eu01-1"
  size              = 5
  source = {
    id   = "3fafe17d-173d-48b2-9961-308246069b16"
    type = "image"
  }
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

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "vault_kv_secret_v2" "example" {
  mount               = stackit_secretsmanager_instance.my_secretsmanager_instance.instance_id
  name                = "my-sh-key"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      public_key  = tls_private_key.example.public_key_openssh
      private_key = tls_private_key.example.private_key_pem
    }
  )
}

resource "stackit_key_pair" "keypair" {
  name       = "example-key-pair"
  public_key = tls_private_key.example.public_key_openssh
}


resource "stackit_security_group" "security_group" {
  project_id  = var.project_id
  name        = "web-server-sg"
  description = "Security group for web server"
}

resource "stackit_security_group_rule" "security_group_rule" {
  project_id        = var.project_id
  security_group_id = stackit_security_group.security_group.security_group_id
  direction         = "ingress"
  protocol = {
    name = "tcp"
  }
  port_range = {
    min = 22
    max = 22
  }
  ip_range = "0.0.0.0/0"
}

resource "stackit_network" "network" {
  project_id         = var.project_id
  name               = "example-network"
  ipv4_nameservers   = ["192.0.2.0", "198.51.100.0", "203.0.113.0"]
  ipv4_prefix_length = 24
}

resource "stackit_network_interface" "nic" {
  project_id         = var.project_id
  network_id         = stackit_network.network.network_id
  security_group_ids = [stackit_security_group.security_group.security_group_id]
}


resource "stackit_server" "web_server" {
  project_id = var.project_id
  name       = "web-server"
  boot_volume = {
    source_id   = stackit_volume.web_server_volume.volume_id
    source_type = "volume"
  }
  machine_type = "t1.1"
  keypair_name = stackit_key_pair.keypair.name
}

resource "stackit_public_ip" "public-ip" {
  project_id           = var.project_id
  network_interface_id = stackit_network_interface.nic.network_interface_id
}

resource "stackit_server_network_interface_attach" "nic-attachment" {
  project_id           = var.project_id
  server_id            = stackit_server.web_server.server_id
  network_interface_id = stackit_network_interface.nic.network_interface_id
}
