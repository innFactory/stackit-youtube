variable "project_id" {
  description = "project_id"
  type        = string
  default     = "f16fbcbe-e47b-472e-9ef4-35b7660c2451"
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
