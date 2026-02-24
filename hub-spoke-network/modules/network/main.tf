terraform {
  required_providers {
    stackit = {
      source = "stackitcloud/stackit"
    }
  }
}

resource "stackit_network" "hub_network" {
  project_id       = var.hub_project_id
  name             = "hub_network"
  ipv4_prefix      = "10.42.0.0/24"
  ipv4_nameservers = []
  routed           = true
}

resource "stackit_network" "p1_network" {
  project_id       = var.project1_id
  name             = "project1_network"
  ipv4_prefix      = "10.42.1.0/24"
  ipv4_nameservers = []
  routed           = true
}

resource "stackit_network" "p2_network" {
  project_id       = var.project2_id
  name             = "project2_network"
  ipv4_prefix      = "10.42.2.0/24"
  ipv4_nameservers = []
  routed           = true
}
