variable "project_id" {
  description = "project_id"
  type        = string
  default     = "3404c67d-d14f-47ab-9d30-8d135702505f"
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
