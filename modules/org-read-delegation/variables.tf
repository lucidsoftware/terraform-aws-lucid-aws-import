variable "account_id" {
  description = "The ID of the bastion account to delegate read organization access to. Optional unless you want to delegate to an existing account"
  type        = string
}

variable "account_email" {
  description = "The email of the new bastion account to delegate read organization access to"
  type        = string
  default     = null
}

variable "account_name" {
  description = "The name of the new bastion account to delegate read organization access to"
  type        = string
  default     = null
}

variable "parent_id" {
  description = "The ID of the parent organizational unit or root to create the new bastion account in"
  type        = string
  default     = null
}
