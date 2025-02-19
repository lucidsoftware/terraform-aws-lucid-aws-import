data "aws_partition" "current" {}

locals {
  # This is the Lucid's AWS import proxy account. It is used to assume the role to do AWS imports. 799803075172 for commercial and 239369393023 for govcloud
  import_proxy_account_id = data.aws_partition.current.partition == "aws-us-gov" ? "239369393023" : "799803075172"
}

data "aws_iam_policy_document" "bastion_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:${data.aws_partition.current.partition}:iam::${local.import_proxy_account_id}:root"]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.external_id]
    }
  }
}

resource "aws_iam_role" "bastion_role" {
  name               = var.bastion_role_name
  assume_role_policy = data.aws_iam_policy_document.bastion_assume_role_policy.json
}

data "aws_iam_policy_document" "bastion_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    resources = [
      # We wildcard the account ID so that we don't have to enumerate all member account IDs
      "arn:${data.aws_partition.current.partition}:iam::*:role/${var.member_account_role_name}"
    ]
  }
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
    resources = ["*"]
  }
}

resource "aws_iam_policy" "bastion_role_policy" {
  name        = var.role_policy_name
  description = "Policy for assuming cross role access and organizational read permissions. Used for Lucid AWS imports"
  policy      = data.aws_iam_policy_document.bastion_role_policy.json
}

resource "aws_iam_role_policy_attachment" "bastion_role_policy" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = aws_iam_policy.bastion_role_policy.arn
}
