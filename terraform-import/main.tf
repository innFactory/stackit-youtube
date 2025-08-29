terraform {
  required_providers {
    stackit = {
      source  = "stackitcloud/stackit"
      version = "0.61.0"
    }
  }
}

provider "stackit" {
  default_region           = "eu01"
  service_account_key_path = var.service_account_key_path
  private_key_path         = var.private_key_path
}

import {
  to = stackit_server.my_server
  id = "${var.project_id},3dec2bd0-be55-4cd5-9b31-1024f5076c05"
}

import {
  to = stackit_network.my_network
  id = "${var.project_id},8200b920-a35f-4eb9-a77a-d88c07e53753"
}

import {
  to = stackit_volume.my_volume
  id = "${var.project_id},c440b37e-58e3-460a-94ce-09c9e3374396"
}

import {
  to = stackit_security_group.my_security_group
  id = "${var.project_id},5477f44e-8727-4c11-92b9-1fe489b2ef04"
}

import {
  to = stackit_network_interface.my_nic
  id = "${var.project_id},8200b920-a35f-4eb9-a77a-d88c07e53753,58065b9b-7f11-4079-b4e5-0ad48d863f13"
}

import {
  to = stackit_server_network_interface_attach.my_nic_attach
  id = "${var.project_id},3dec2bd0-be55-4cd5-9b31-1024f5076c05,58065b9b-7f11-4079-b4e5-0ad48d863f13"
}
