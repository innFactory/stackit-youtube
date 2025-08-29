
# Import Terraform resources

## Generate Terraform configuration
Run `terraform plan -generate-config-out=generated.tf` to let terraform generate the configuration


## Get resource ID's via STACKIT-CLI
1. `stackit auth login`
2. `stackit config set --project-id 3e69dfdb-8fed-421b-b9d1-3a763e805c0f`
3. `stackit network list`
4. `stackit network-interface list --network-id 8200b920-a35f-4eb9-a77a-d88c07e53753`