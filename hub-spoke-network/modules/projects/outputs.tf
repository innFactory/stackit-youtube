output "hub_project_id" {
  description = "The hub project ID"
  value       = stackit_resourcemanager_project.hub.project_id
}

output "project1_id" {
  description = "The project1 ID"
  value       = stackit_resourcemanager_project.project1.project_id
}

output "project2_id" {
  description = "The project2 ID"
  value       = stackit_resourcemanager_project.project2.project_id
}
