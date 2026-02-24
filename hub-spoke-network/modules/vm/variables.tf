variable "project1_id" {
  description = "The project1 ID"
  type        = string
}

variable "project2_id" {
  description = "The project2 ID"
  type        = string
}

variable "p1_network_id" {
  description = "The project1 network ID"
  type        = string
}

variable "p2_network_id" {
  description = "The project2 network ID"
  type        = string
}

variable "image_id" {
  description = "The image ID to use for the VMs (Ubuntu 24.04)"
  type        = string
  default     = "fb5b3fa8-5e20-478a-929a-2b7da1676b18" # Ubuntu 24.04 (latest)
}
