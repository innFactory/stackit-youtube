output "hub_network_id" {
  description = "The hub network ID"
  value       = stackit_network.hub_network.network_id
}

output "p1_network_id" {
  description = "The project1 network ID"
  value       = stackit_network.p1_network.network_id
}

output "p2_network_id" {
  description = "The project2 network ID"
  value       = stackit_network.p2_network.network_id
}
