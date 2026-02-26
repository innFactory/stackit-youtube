terraform {
  required_providers {
    stackit = {
      source  = "stackitcloud/stackit"
      version = "0.82.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
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

module "projects" {
  source = "./modules/projects"

  organization_id = var.organization_id
  network_area_id = stackit_network_area.sna.network_area_id
  owner_email     = var.service_account_email
}

module "networks" {
  source = "./modules/network"

  hub_project_id = module.projects.hub_project_id
  project1_id    = module.projects.project1_id
  project2_id    = module.projects.project2_id
}

module "vms" {
  source = "./modules/vm"

  hub_project_id = module.projects.hub_project_id
  hub_network_id = module.networks.hub_network_id
  project1_id    = module.projects.project1_id
  project2_id    = module.projects.project2_id
  p1_network_id  = module.networks.p1_network_id
  p2_network_id  = module.networks.p2_network_id
}
