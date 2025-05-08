terraform {
  required_providers {
    stackit = {
      source = "stackitcloud/stackit"
    }
    tls = {
      source = "hashicorp/tls"
    }
    vault = {
      source = "hashicorp/vault"
    }
  }
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "vault_kv_secret_v2" "example" {
  mount               = var.secretsmanager_instance_id
  name                = "my-sh-key"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      public_key  = tls_private_key.example.public_key_openssh
      private_key = tls_private_key.example.private_key_pem
    }
  )
}

resource "stackit_key_pair" "keypair" {
  name       = "example-key-pair"
  public_key = tls_private_key.example.public_key_openssh
}
