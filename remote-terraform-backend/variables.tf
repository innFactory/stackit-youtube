variable "project_id" {
  description = "project_id"
  type        = string
  default     = "17dba736-7419-4eca-8ff0-674fc61ccc34"
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
