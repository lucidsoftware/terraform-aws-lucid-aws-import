# Lucid AWS Import Modules

This repository contains Terraform modules to set up the necessary IAM roles and policies for Lucid AWS imports. These modules include:

- **Org Read Delegation Module**: Sets up a bastion account (optionally) and delegates read access to the organization
- **Bastion Role Module**: Sets up an IAM role in the bastion account to assume roles in member accounts for imports.
- **Import Role Module**: Sets up an IAM role in any AWS account for Lucid to perform imports.

For Org Level Import, all 3 modules are required. For Non-Org Level Import, only **Import Role Module** is required.

## Modules

### Org Read Delegation Module

This module sets up a bastion account and delegates read access to the organization, either by creating a new account or using an existing one.

[Read more](https://github.com/lucidsoftware/terraform-aws-lucid-aws-import/tree/main/modules/org-read-delegation)

### Bastion Role Module

This module creates an IAM role in the bastion account that allows Lucid's AWS import proxy account to assume it and perform imports in member accounts.

[Read more](https://github.com/lucidsoftware/terraform-aws-lucid-aws-import/tree/main/modules/bastion-role)

### Import Role Module

This module creates an IAM role that can be assumed by Lucid's proxy AWS import account or the bastion account for performing imports.

[Read more](https://github.com/lucidsoftware/terraform-aws-lucid-aws-import/tree/main/modules/import-role)

## Requirements

| Name | Version |
|------|---------|
| [terraform](https://www.terraform.io/) | >= 1.4 |
| [aws](https://aws.amazon.com/) | >= 5.0 |

## License

This project is licensed under the Apache License, Version 2.0. See the [LICENSE](https://github.com/lucidsoftware/terraform-aws-lucid-aws-import/blob/main/LICENSE) file for details.