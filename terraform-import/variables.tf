variable "project_id" {
  description = "project_id"
  type        = string
  default     = "3aa36366-e476-4971-9f67-37d8de6e7324"
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
