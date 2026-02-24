terraform {
  required_providers {
    stackit = {
      source = "stackitcloud/stackit"
    }
  }
}

resource "stackit_resourcemanager_project" "hub" {
  parent_container_id = var.organization_id
  name                = "hub"
  labels = {
    "networkArea" = var.network_area_id
  }
  owner_email = var.owner_email
}

resource "stackit_resourcemanager_project" "project1" {
  parent_container_id = var.organization_id
  name                = "project1"
  labels = {
    "networkArea" = var.network_area_id
  }
  owner_email = var.owner_email
}

resource "stackit_resourcemanager_project" "project2" {
  parent_container_id = var.organization_id
  name                = "project2"
  labels = {
    "networkArea" = var.network_area_id
  }
  owner_email = var.owner_email
}
