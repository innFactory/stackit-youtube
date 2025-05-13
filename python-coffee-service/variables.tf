variable "project_id" {
  description = "project_id"
  type        = string
  default     = "ff94ba73-704a-4616-9a9d-6ac2f7d84592"
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
