data "aws_partition" "current" {}

locals {
  bastion_account_id = var.account_id != null ? var.account_id : aws_organizations_account.bastion_account[0].id
}

resource "aws_organizations_account" "bastion_account" {
  count = var.account_id == null ? 1 : 0

  name      = var.account_name
  email     = var.account_email
  parent_id = var.parent_id
}

data "aws_iam_policy_document" "read_organization_access_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "organizations:DescribeAccount",
      "organizations:DescribeOrganization",
      "organizations:DescribeOrganizationalUnit",
      "organizations:ListAccounts",
      "organizations:ListAccountsForParent",
      "organizations:ListChildren",
      "organizations:ListOrganizationalUnitsForParent",
      "organizations:ListParents",
      "organizations:ListRoots",
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:${data.aws_partition.current.partition}:iam::${local.bastion_account_id}:root"]
    }
    resources = ["*"]
  }
}

resource "aws_organizations_resource_policy" "read_organization_access_policy" {
  content = data.aws_iam_policy_document.read_organization_access_policy_document.json
}
