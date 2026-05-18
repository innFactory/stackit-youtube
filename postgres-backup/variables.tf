variable "project_id" {
  description = "project_id"
  type        = string
  default     = "e83611ea-c0bc-48ad-986b-cb6798befa0d"
}

variable "service_account_key_path" {
  description = "service_account_key_path"
  type        = string
  default     = "../sa_key.json"
}

variable "private_key_path" {
  description = "private_key_path"
  type        = string
  default     = "/Users/a.spoeck/.ssh/stackit"
}
