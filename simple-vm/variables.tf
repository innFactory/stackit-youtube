variable "project_id" {
  description = "project_id"
  type        = string
  default     = "04f3336e-4d93-4067-9fc1-0f4c8da0b695"
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
