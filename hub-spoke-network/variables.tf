variable "organization_id" {
  description = "organization_id"
  type        = string
  default     = "fcd480a7-75a3-4c83-b5e0-164169281919"
}

variable "service_account_email" {
  description = "service_account_email"
  type        = string
  default     = "terraform-k4zh3xi8@sa.stackit.cloud"
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
