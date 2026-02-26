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

# Key pair for all vms (please use in prod env one key for each vm)
resource "stackit_key_pair" "general" {
  name       = "general-keypair"
  public_key = tls_private_key.ssh.public_key_openssh
}

# Security group for hub VM - allows SSH
resource "stackit_security_group" "hub" {
  project_id = var.hub_project_id
  name       = "hub-sg"
  stateful   = true
}

# Allow SSH ingress to hub VM
resource "stackit_security_group_rule" "hub_ssh" {
  project_id        = var.hub_project_id
  security_group_id = stackit_security_group.hub.security_group_id
  direction         = "ingress"
  ether_type        = "IPv4"
  protocol = {
    name = "tcp"
  }
  port_range = {
    min = 22
    max = 22
  }
}


# Network interface for hub VM
resource "stackit_network_interface" "hub" {
  project_id         = var.hub_project_id
  network_id         = var.hub_network_id
  security_group_ids = [stackit_security_group.hub.security_group_id]
}

# Security group for project1 VM - allows SSH from network area
resource "stackit_security_group" "project1" {
  project_id = var.project1_id
  name       = "project1-sg"
  stateful   = true
}

# Allow SSH ingress to project1 VM from network area
resource "stackit_security_group_rule" "project1_ssh" {
  project_id        = var.project1_id
  security_group_id = stackit_security_group.project1.security_group_id
  direction         = "ingress"
  ether_type        = "IPv4"
  ip_range          = "10.42.0.0/24"
  protocol = {
    name = "tcp"
  }
  port_range = {
    min = 22
    max = 22
  }
}

# Security group for project2 VM - allows SSH from network area
resource "stackit_security_group" "project2" {
  project_id = var.project2_id
  name       = "project2-sg"
  stateful   = true
}

# Allow SSH ingress to project2 VM from network area
resource "stackit_security_group_rule" "project2_ssh" {
  project_id        = var.project2_id
  security_group_id = stackit_security_group.project2.security_group_id
  direction         = "ingress"
  ether_type        = "IPv4"
  ip_range          = "10.42.0.0/24"
  protocol = {
    name = "tcp"
  }
  port_range = {
    min = 22
    max = 22
  }
}

# Network interface for project1 VM
resource "stackit_network_interface" "project1" {
  project_id         = var.project1_id
  network_id         = var.p1_network_id
  security_group_ids = [stackit_security_group.project1.security_group_id]
}

# Network interface for project2 VM
resource "stackit_network_interface" "project2" {
  project_id         = var.project2_id
  network_id         = var.p2_network_id
  security_group_ids = [stackit_security_group.project2.security_group_id]
}

# Volume for hub VM with Ubuntu
resource "stackit_volume" "hub" {
  project_id        = var.hub_project_id
  availability_zone = "eu01-1"
  name              = "vm-hub-volume"
  size              = 5
  source = {
    type = "image"
    id   = var.image_id
  }
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

# Hub VM - boot from volume
resource "stackit_server" "hub" {
  project_id        = var.hub_project_id
  name              = "vm-hub"
  availability_zone = "eu01-1"
  machine_type      = "t2i.1"
  keypair_name      = stackit_key_pair.general.name
  boot_volume = {
    source_type = "volume"
    source_id   = stackit_volume.hub.volume_id
  }
  network_interfaces = [
    stackit_network_interface.hub.network_interface_id
  ]
}

# Public IP for hub VM
resource "stackit_public_ip" "hub" {
  project_id           = var.hub_project_id
  network_interface_id = stackit_network_interface.hub.network_interface_id
}

# VM in project1 - boot from volume
resource "stackit_server" "project1" {
  project_id        = var.project1_id
  name              = "vm-project1"
  availability_zone = "eu01-1"
  machine_type      = "t2i.1"
  keypair_name      = stackit_key_pair.general.name
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
  keypair_name      = stackit_key_pair.general.name
  boot_volume = {
    source_type = "volume"
    source_id   = stackit_volume.project2.volume_id
  }
  network_interfaces = [
    stackit_network_interface.project2.network_interface_id
  ]
}
