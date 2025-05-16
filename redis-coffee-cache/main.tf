terraform {
  required_providers {
    stackit = {
      source  = "stackitcloud/stackit"
      version = "0.53.0"
    }
  }
}

provider "stackit" {
  default_region           = "eu01"
  service_account_key_path = var.service_account_key_path
  private_key_path         = var.private_key_path
}


resource "stackit_redis_instance" "coffee_cache_instance" {
  project_id = var.project_id
  name       = "coffee-cache-instance"
  version    = "7"
  plan_name  = "stackit-redis-1.4.10-single"
  parameters = {
    #sgw_acl = "0.0.0.0/0" # !!! Do not allow public access in production !!!!
    sgw_acl = "193.148.160.0/19,45.129.40.0/21,45.135.244.0/22"

  }
}

resource "stackit_redis_credential" "example" {
  project_id  = var.project_id
  instance_id = stackit_redis_instance.coffee_cache_instance.instance_id

}
