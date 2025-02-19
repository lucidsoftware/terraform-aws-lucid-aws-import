variable "assume_role_account_id" {
  description = "The ID of the account to assume the role (used to set up role assumption permissions). This should be the bastion account id for org level imports. For non-org level imports, it should use Lucid's AWS import proxy account id - 799803075172 for commercial and 239369393023 for govcloud"
  type        = string
}

variable "external_id" {
  description = "The external id generated by Lucid that uniquely associates this role with the Lucid AWS proxy account. Only used for non-org imports (for org import this is provided on the bastion import role instead)"
  type        = string
  default     = null
  sensitive   = true
}

variable "non_org_import" {
  description = "If this role is used for non-org import. This variable is to work around a bug where sensitive values can't be used in a dynamic for_each (https://github.com/hashicorp/terraform/issues/29744)"
  type        = bool
  default     = false
}

variable "policy_name" {
  description = "The name of the policy to give permission to Lucid to do imports"
  type        = string
  default     = "lucid_import"
}

variable "role_name" {
  description = "The name of the member account role"
  type        = string
  default     = "lucid_import"
}
