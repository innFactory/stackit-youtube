output "ssh_private_key" {
  description = "The SSH private key (sensitive)"
  value       = tls_private_key.ssh.private_key_pem
  sensitive   = true
}

output "ssh_public_key" {
  description = "The SSH public key"
  value       = tls_private_key.ssh.public_key_openssh
}

output "hub_server_id" {
  description = "The hub server ID"
  value       = stackit_server.hub.server_id
}

output "hub_public_ip" {
  description = "The hub VM public IP"
  value       = stackit_public_ip.hub.ip
}

output "hub_private_ip" {
  description = "The hub VM private IP"
  value       = stackit_network_interface.hub.ipv4
}

output "project1_server_id" {
  description = "The project1 server ID"
  value       = stackit_server.project1.server_id
}

output "project1_private_ip" {
  description = "The project1 VM private IP"
  value       = stackit_network_interface.project1.ipv4
}

output "project2_server_id" {
  description = "The project2 server ID"
  value       = stackit_server.project2.server_id
}

output "project2_private_ip" {
  description = "The project2 VM private IP"
  value       = stackit_network_interface.project2.ipv4
}
