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
  id = "${var.project_id},36f3f5f6-2e7f-48a8-b3c7-510e1c208503"
}

import {
  to = stackit_network.my_network
  id = "${var.project_id},15bb2cdb-f920-4f98-88c6-13fd4f5405d3"
}

import {
  to = stackit_volume.my_volume
  id = "${var.project_id},ef55112d-1f0c-4f92-9d3b-15a54eb54172"
}


import {
  to = stackit_security_group.my_security_group
  id = "${var.project_id},2f9525dc-3c19-47a8-961f-36c5a143d736"
}

import {
  to = stackit_network_interface.my_nic
  id = "${var.project_id},15bb2cdb-f920-4f98-88c6-13fd4f5405d3,c9178bee-03f7-45ff-96df-9c5e9fb1a631"
}

import {
  to = stackit_server_network_interface_attach.my_nic_attach
  id = "${var.project_id},36f3f5f6-2e7f-48a8-b3c7-510e1c208503,c9178bee-03f7-45ff-96df-9c5e9fb1a631"
}
