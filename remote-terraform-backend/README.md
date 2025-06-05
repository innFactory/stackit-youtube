# Terraform
## S3 Backend for tfstate

* `stackit auth login`
* `stackit project list`
* `stackit config set --project-id 17dba736-7419-4eca-8ff0-674fc61ccc34`
* `stackit object-storage enable`

Note: The name must be globally unique. Use only lowercase letters, numbers or hyphens. The name should be at least 3 and at most 63 characters long.

Lets use something kinda random, to have a higher chance of catching an free bucket name:

* `stackit object-storage bucket create tfstate-bucket-a2xt`
* `stackit object-storage credentials-group create --name terraform-state`
* `stackit object-storage credentials-group list`
* `stackit object-storage credentials create --credentials-group-id bc0c3168-6336-4cf1-94fa-2742de9ae751`

* `terraform init --backend-config=./config.s3.tfbackend`