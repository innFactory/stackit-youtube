variable "project_id" {
  description = "project_id"
  type        = string
  default     = "12e3195a-e00b-43bb-bb67-12fda8f45860"
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
