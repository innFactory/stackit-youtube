terraform {
  required_providers {
    stackit = {
      source = "stackitcloud/stackit"
    }
  }
}


resource "stackit_objectstorage_bucket" "coffee_image_bucket" {
  project_id = var.project_id
  name       = "coffee-image-bucket"
}

resource "stackit_objectstorage_credentials_group" "coffee_image_group" {
  project_id = var.project_id
  name       = "coffee-image-group"
}

resource "stackit_objectstorage_credential" "bucket_credentials" {
  project_id           = var.project_id
  credentials_group_id = stackit_objectstorage_credentials_group.coffee_image_group.credentials_group_id
  expiration_timestamp = "2027-01-02T03:04:05Z"
}

provider "aws" {
  region                      = "eu01"
  skip_credentials_validation = true
  skip_region_validation      = true
  skip_requesting_account_id  = true
  access_key                  = stackit_objectstorage_credential.bucket_credentials.access_key
  secret_key                  = stackit_objectstorage_credential.bucket_credentials.secret_access_key
  endpoints {
    s3 = "https://object.storage.eu01.onstackit.cloud"
  }
}

resource "aws_s3_object" "image" {
  bucket       = stackit_objectstorage_bucket.coffee_image_bucket.name
  key          = "coffee-${count.index}.png"
  source       = "./coffee-image-bucket/assets/img-${count.index}.png"
  content_type = "image/png"
  etag         = filemd5("./coffee-image-bucket/assets/img-${count.index}.png")
  count        = 9
}
