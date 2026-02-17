variable "project_id" {
  description = "project_id"
  type        = string
  default     = "4bb70afe-4bec-4254-8810-e26892178fc6"
}

variable "service_account_key_path" {
  description = "service_account_key_path"
  type        = string
  default     = "../sa_key.json"
}

variable "private_key_path" {
  description = "private_key_path"
  type        = string
  default     = "Users/a.spoeck/.ssh/id_rsa_stackit"
}
