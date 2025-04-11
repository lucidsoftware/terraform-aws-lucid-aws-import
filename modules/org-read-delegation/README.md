# Lucid AWS Import Org Read Delegation Module

This module is only required for Org Level Import.

This module should be set up in the management/root account in the organization. 

This module will create a bastion account with the provided account email and account name if no account id is provided. If an account id is provided, we will use that account as the bastion account.

It will then delegate administrator access to the bastion account. This account will receive organization-level permissions to scan your organization structure and configure permissions for member accounts.

### Note
AWS Organization allows you to have only one resource policy per organization. If you already have an existing resource policy in your organization, this module will fail to deploy as it attemptes to create a new `aws_organizations_resource_policy`. 

You'd need to manually modify or extend the existing policy. Add the [actions](modules/org-read-delegation/main.tf#L18) and [principals](modules/org-read-delegation/main.tf#L29) to your policy.

For creating a new bastion account if you don't have one already, follow the [implementation](modules/org-read-delegation/main.tf#L7) in the module.

## Usage

### Creating A New Bastion Account

```hcl
module "org_read_delegation" {
  source = "../modules/org-read-delegation"

  account_email = "your_account_email"
  account_name  = "your_account_name"
}
```

### Delegating An Existing Bastion Account

```hcl
module "org_read_delegation" {
  source = "../modules/org-read-delegation"

  account_id    = "your_account_id"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The ID of the bastion account to delegate read organization access to. Optional unless you want to delegate to an existing account | `string` | `null` | no |
| <a name="input_account_email"></a> [account\_email](#input\_account\_email) | The email of the new bastion account to delegate read organization access to | `string` | `null` | no |
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | The name of the new bastion account to delegate read organization access to | `string` | `null` | no |
| <a name="input_parent_id"></a> [parent\_id](#input\_parent\_id) | The ID of the parent organizational unit or root to create the new bastion account in | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_account_id"></a> [bastion\_account\_id](#output\_bastion\_account\_id) | The ID of the bastion account |
| <a name="output_bastion_account_email"></a> [bastion\_account\_email](#output\_bastion\_account\_email) | The email of the bastion account |
| <a name="output_bastion_account_name"></a> [bastion\_account\_name](#output\_bastion\_account\_name) | The name of the bastion account |
