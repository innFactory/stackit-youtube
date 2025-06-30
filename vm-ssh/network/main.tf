terraform {
  required_providers {
    stackit = {
      source = "stackitcloud/stackit"
    }
  }
}


resource "stackit_security_group" "security_group" {
  project_id  = var.project_id
  name        = "my-server-sg"
  description = "Security group for my server"
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
  ipv4_nameservers   = ["1.1.1.1", "8.8.8.8", "6.6.6.6"]
  ipv4_prefix_length = 24
}

resource "stackit_network_interface" "nic" {
  project_id         = var.project_id
  network_id         = stackit_network.network.network_id
  security_group_ids = [stackit_security_group.security_group.security_group_id]
}

resource "stackit_public_ip" "public-ip" {
  project_id           = var.project_id
  network_interface_id = stackit_network_interface.nic.network_interface_id
}

resource "stackit_server_network_interface_attach" "nic-attachment" {
  project_id           = var.project_id
  server_id            = var.server_id
  network_interface_id = stackit_network_interface.nic.network_interface_id
}
