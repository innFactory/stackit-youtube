terraform {
  required_providers {
    stackit = {
      source  = "stackitcloud/stackit"
      version = "0.82.0"
    }
  }
}

provider "stackit" {
  default_region           = "eu01"
  service_account_key_path = var.service_account_key_path
  private_key_path         = var.private_key_path
}

resource "stackit_network_area" "sna" {
  organization_id = var.organization_id
  name            = "sna"
}

# Add the new resource "stackit_network_area_region" and configure it with all the deprecated values from the "stackit_network_area" resource
resource "stackit_network_area_region" "sna_region" {
  organization_id = var.organization_id
  network_area_id = stackit_network_area.sna.network_area_id
  region          = "eu01"
  ipv4 = {
    transfer_network = "172.16.0.0/16"
    network_ranges = [
      {
        prefix = "10.42.0.0/16"
      }
    ]
    default_nameservers   = ["1.1.1.1"]
    default_prefix_length = 24
    max_prefix_length     = 29
    min_prefix_length     = 24
  }
}


resource "stackit_resourcemanager_project" "hub" {
  parent_container_id = var.organization_id
  name                = "hub"
  labels = {
    "networkArea" = stackit_network_area.sna.network_area_id
  }
  owner_email = var.service_account_email
}


resource "stackit_resourcemanager_project" "project1" {
  parent_container_id = var.organization_id
  name                = "project1"
  labels = {
    "networkArea" = stackit_network_area.sna.network_area_id
  }
  owner_email = var.service_account_email
}

resource "stackit_resourcemanager_project" "project2" {
  parent_container_id = var.organization_id
  name                = "project2"
  labels = {
    "networkArea" = stackit_network_area.sna.network_area_id
  }
  owner_email = var.service_account_email
}

resource "stackit_network" "hub_network" {
  project_id       = stackit_resourcemanager_project.hub.project_id
  name             = "hub_network"
  ipv4_prefix      = "10.42.0.0/24"
  ipv4_nameservers = []
  routed           = true
}

resource "stackit_network" "p1_network" {
  project_id       = stackit_resourcemanager_project.project1.project_id
  name             = "project1_network"
  ipv4_prefix      = "10.42.1.0/24"
  ipv4_nameservers = []
  routed           = true
}

resource "stackit_network" "p2_network" {
  project_id       = stackit_resourcemanager_project.project2.project_id
  name             = "project2_network"
  ipv4_prefix      = "10.42.2.0/24"
  ipv4_nameservers = []
  routed           = true
}