# Terraform

## set project
* `stackit auth login`
* `stackit project list`
* `stackit config set --project-id 18f0295a-7a87-4e24-af12-39aecaa96cff`

## service account sa_key.json
`stackit service-account create --name terraform`
`stackit service-account list`
`stackit service-account key create --email terraform-XXXXXXX@sa.stackit.cloud > sa_key.json`
`stackit project member add terraform-XXXXXXX@sa.stackit.cloud --role editor`


## set path to private_key_path in `variables.tf`

## Init and Run Terraform
* `terraform init`
* `terraform apply`