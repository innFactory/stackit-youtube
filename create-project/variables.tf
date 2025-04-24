variable "service_account_key_path" {
  description = "service_account_key_path"
  type        = string
  default     = "./sa.json"
}

variable "private_key_path" {
  description = "private_key_path"
  type        = string
  default     = "Users/myUser/.ssh/id_rsa_stackit"
}