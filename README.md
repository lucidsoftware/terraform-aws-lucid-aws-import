# Lucid AWS Import Modules

This repository contains Terraform modules to set up the necessary IAM roles and policies for Lucid AWS imports. These modules include:

- **Org Read Delegation Module**: Sets up a bastion account (optionally) and delegates read access to the organization
- **Bastion Role Module**: Sets up an IAM role in the bastion account to assume roles in member accounts for imports.
- **Import Role Module**: Sets up an IAM role in any AWS account for Lucid to perform imports.

## Modules

### Org Read Delegation Module

This module sets up a bastion account and delegates read access to the organization, either by creating a new account or using an existing one.

[Read more](modules/org-read-delegation/README.md)

### Bastion Role Module

This module creates an IAM role in the bastion account that allows Lucid's AWS import proxy account to assume it and perform imports in member accounts.

[Read more](modules/bastion-role/README.md)

### Import Role Module

This module creates an IAM role that can be assumed by Lucid's proxy AWS import account or the bastion account for performing imports.

[Read more](modules/import-role/README.md)

## Requirements

| Name | Version |
|------|---------|
| [terraform](https://www.terraform.io/) | >= 1.4 |
| [aws](https://aws.amazon.com/) | >= 5.0 |

## License

This project is licensed under the Apache License, Version 2.0. See the [LICENSE](LICENSE) file for details.