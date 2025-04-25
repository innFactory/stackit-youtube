terraform {
  required_providers {
    stackit = {
      source  = "stackitcloud/stackit"
      version = "0.50.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "stackit" {
  default_region           = "eu01"
  service_account_key_path = var.service_account_key_path
  private_key_path         = var.private_key_path
}

resource "stackit_objectstorage_bucket" "innfactory_example_bucket" {
  project_id = var.project_id
  name       = "innfactory-example-bucket"
}

resource "stackit_objectstorage_credentials_group" "test_credentials_group" {
  project_id = var.project_id
  name       = "test-credentials-group"
}

resource "stackit_objectstorage_credential" "bucket_credentials" {
  project_id           = var.project_id
  credentials_group_id = stackit_objectstorage_credentials_group.test_credentials_group.credentials_group_id
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
  bucket       = stackit_objectstorage_bucket.innfactory_example_bucket.name
  key          = "image.png"
  source       = "./image.png"
  content_type = "image/png"
  etag         = filemd5("./image.png")
}

resource "aws_s3_bucket_policy" "allow_public_read_access" {
  bucket = stackit_objectstorage_bucket.innfactory_example_bucket.name
  policy = <<EOF
     {
        "Statement":[
           {
           "Sid": "Public GET",
           "Effect":"Allow",
           "Principal":"*",
           "Action":"s3:GetObject",
           "Resource":"urn:sgws:s3:::innfactory-example-bucket/image.png"
           }
        ]
     }
     EOF
}

resource "aws_s3_bucket_cors_configuration" "set_cors" {
  bucket = stackit_objectstorage_bucket.innfactory_example_bucket.name

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["https://innfactory.de"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}
