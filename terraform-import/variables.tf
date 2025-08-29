variable "project_id" {
  description = "project_id"
  type        = string
  default     = "3e69dfdb-8fed-421b-b9d1-3a763e805c0f"
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
