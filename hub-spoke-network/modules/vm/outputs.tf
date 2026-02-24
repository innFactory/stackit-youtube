output "ssh_private_key" {
  description = "The SSH private key (sensitive)"
  value       = tls_private_key.ssh.private_key_pem
  sensitive   = true
}

output "ssh_public_key" {
  description = "The SSH public key"
  value       = tls_private_key.ssh.public_key_openssh
}

output "project1_server_id" {
  description = "The project1 server ID"
  value       = stackit_server.project1.server_id
}

output "project2_server_id" {
  description = "The project2 server ID"
  value       = stackit_server.project2.server_id
}
