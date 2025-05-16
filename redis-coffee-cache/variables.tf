variable "project_id" {
  description = "project_id"
  type        = string
  default     = "92e9c0dc-d2ae-4a74-989c-1f01ade5bd91"
}

variable "service_account_key_path" {
  description = "service_account_key_path"
  type        = string
  default     = "../sa.json"
}

variable "private_key_path" {
  description = "private_key_path"
  type        = string
  default     = "Users/spoeck/.ssh/id_rsa_stackit"
}
