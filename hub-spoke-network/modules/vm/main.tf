terraform {
  required_providers {
    stackit = {
      source = "stackitcloud/stackit"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
}

# Generate SSH key pair
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Key pair for project1
resource "stackit_key_pair" "project1" {
  name       = "vm1-keypair"
  public_key = tls_private_key.ssh.public_key_openssh
}

# Key pair for project2
resource "stackit_key_pair" "project2" {
  name       = "vm2-keypair"
  public_key = tls_private_key.ssh.public_key_openssh
}

# Network interface for project1 VM
resource "stackit_network_interface" "project1" {
  project_id = var.project1_id
  network_id = var.p1_network_id
}

# Network interface for project2 VM
resource "stackit_network_interface" "project2" {
  project_id = var.project2_id
  network_id = var.p2_network_id
}

# Volume for project1 VM with Ubuntu
resource "stackit_volume" "project1" {
  project_id        = var.project1_id
  availability_zone = "eu01-1"
  name              = "vm-project1-volume"
  size              = 5
  source = {
    type = "image"
    id   = var.image_id
  }
}

# Volume for project2 VM with Ubuntu
resource "stackit_volume" "project2" {
  project_id        = var.project2_id
  availability_zone = "eu01-1"
  name              = "vm-project2-volume"
  size              = 5
  source = {
    type = "image"
    id   = var.image_id
  }
}

# VM in project1 - boot from volume
resource "stackit_server" "project1" {
  project_id        = var.project1_id
  name              = "vm-project1"
  availability_zone = "eu01-1"
  machine_type      = "t2i.1"
  keypair_name      = stackit_key_pair.project1.name
  boot_volume = {
    source_type = "volume"
    source_id   = stackit_volume.project1.volume_id
  }
  network_interfaces = [
    stackit_network_interface.project1.network_interface_id
  ]
}

# VM in project2 - boot from volume
resource "stackit_server" "project2" {
  project_id        = var.project2_id
  name              = "vm-project2"
  availability_zone = "eu01-1"
  machine_type      = "t2i.1"
  keypair_name      = stackit_key_pair.project2.name
  boot_volume = {
    source_type = "volume"
    source_id   = stackit_volume.project2.volume_id
  }
  network_interfaces = [
    stackit_network_interface.project2.network_interface_id
  ]
}
