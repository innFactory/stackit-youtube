output "ssh_private_key" {
  description = "The SSH private key for VM access"
  value       = nonsensitive(module.vms.ssh_private_key)
}

output "ssh_public_key" {
  description = "The SSH public key"
  value       = module.vms.ssh_public_key
}

output "project1_server_id" {
  description = "The project1 server ID"
  value       = module.vms.project1_server_id
}

output "project2_server_id" {
  description = "The project2 server ID"
  value       = module.vms.project2_server_id
}
