variable "project_id" {
  description = "project_id"
  type        = string
  default     = "18f0295a-7a87-4e24-af12-39aecaa96cff"
}

variable "service_account_key_path" {
  description = "service_account_key_path"
  type        = string
  default     = "./sa_key.json"
}

variable "private_key_path" {
  description = "private_key_path"
  type        = string
  default     = "Users/spoeck/.ssh/id_rsa_stackit"
}
