variable "bastion_role_name" {
  description = "The name of the bastion role"
  type        = string
  default     = "lucid-import-bastion-role"
}

variable "external_id" {
  description = "The external id generated by Lucid that uniquely associates this role with the Lucid AWS proxy account"
  type        = string
  sensitive   = true
}

variable "member_account_role_name" {
  description = "The name of the role in the member account that the bastion role will assume to do imports"
  type        = string
  default     = "lucid-import-account-role"
}

variable "role_policy_name" {
  description = "The name of the policy for assuming cross role access and organizational read permissions (attached to the bastion role). Used for Lucid AWS imports"
  type        = string
  default     = "lucid-import-bastion-policy"
}
