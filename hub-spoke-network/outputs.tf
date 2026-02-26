output "ssh_private_key" {
  description = "The SSH private key for VM access"
  value       = nonsensitive(module.vms.ssh_private_key)
}

output "ssh_public_key" {
  description = "The SSH public key"
  value       = module.vms.ssh_public_key
}

# Hub VM
output "hub_server_id" {
  description = "The hub server ID"
  value       = module.vms.hub_server_id
}

output "hub_public_ip" {
  description = "The hub VM public IP - use this to SSH"
  value       = module.vms.hub_public_ip
}

output "hub_private_ip" {
  description = "The hub VM private IP"
  value       = module.vms.hub_private_ip
}

# Project1 VM
output "project1_server_id" {
  description = "The project1 server ID"
  value       = module.vms.project1_server_id
}

output "project1_private_ip" {
  description = "The project1 VM private IP"
  value       = module.vms.project1_private_ip
}

# Project2 VM
output "project2_server_id" {
  description = "The project2 server ID"
  value       = module.vms.project2_server_id
}

output "project2_private_ip" {
  description = "The project2 VM private IP"
  value       = module.vms.project2_private_ip
}
