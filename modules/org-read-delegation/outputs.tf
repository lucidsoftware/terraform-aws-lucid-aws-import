output "bastion_account_id" {
  description = "The ID of the bastion account (used to set up role assumption permissions)"
  value       = local.bastion_account_id
}
