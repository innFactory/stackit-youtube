
# Import Terraform resources

## Generate Terraform configuration
Run `terraform plan -generate-config-out=generated.tf` to let terraform generate the configuration


## Get resource ID's via STACKIT-CLI
1. `stackit auth login`
2. `stackit config set --project-id 3aa36366-e476-4971-9f67-37d8de6e7324`
3. `stackit network list`
4. `stackit network-interface list --network-id 15bb2cdb-f920-4f98-88c6-13fd4f5405d3`