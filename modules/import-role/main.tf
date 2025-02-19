data "aws_partition" "current" {}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:${data.aws_partition.current.partition}:iam::${var.assume_role_account_id}:root"]
    }
    dynamic "condition" {
      for_each = var.non_org_import ? ["1"] : []
      content {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = [var.external_id]
      }
    }
  }
}

resource "aws_iam_role" "import_role" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "import" {
  statement {
    actions = [
      "apigateway:GET",
      "appsync:ListDataSources",
      "appsync:ListGraphqlApis",
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeLaunchConfigurations",
      "cloudfront:ListDistributions",
      "cloudfront:ListTagsForResource",
      "cloudtrail:DescribeTrails",
      "cloudtrail:ListTags",
      "cloudtrail:ListTrails",
      "cognito-idp:DescribeUserPool",
      "cognito-idp:ListUserPools",
      "dynamodb:DescribeTable",
      "dynamodb:ListTables",
      "dynamodb:ListTagsOfResource",
      "ec2:DescribeCustomerGateways",
      "ec2:DescribeInstances",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeNatGateways",
      "ec2:DescribeNetworkAcls",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeTransitGateways",
      "ec2:DescribeTransitGatewayAttachments",
      "ec2:DescribeTransitGatewayRouteTables",
      "ec2:DescribeVolumes",
      "ec2:DescribeVpcs",
      "ec2:DescribeVpcEndpoints",
      "ec2:DescribeVpcEndpointConnections",
      "ec2:DescribeVpnConnections",
      "ec2:DescribeVpnGateways",
      "ec2:DescribeVpcPeeringConnections",
      "ec2:SearchTransitGatewayRoutes",
      "ecs:DescribeClusters",
      "ecs:DescribeServices",
      "ecs:DescribeTasks",
      "ecs:ListClusters",
      "ecs:ListServices",
      "ecs:ListTasks",
      "eks:DescribeCluster",
      "eks:ListClusters",
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:DescribeMountTargets",
      "elasticache:DescribeCacheClusters",
      "elasticache:DescribeCacheSubnetGroups",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeTags",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticmapreduce:DescribeCluster",
      "elasticmapreduce:ListClusters",
      "es:DescribeElasticsearchDomains",
      "es:ListDomainNames",
      "es:ListTags",
      "events:DescribeEventBus",
      "events:ListEventBuses",
      "events:DescribeRule",
      "events:ListRules",
      "events:ListTagsForResource",
      "firehose:DescribeDeliveryStream",
      "firehose:ListDeliveryStreams",
      "firehose:ListTagsForDeliveryStream",
      "glacier:DescribeVault",
      "glacier:ListVaults",
      "iam:ListAccountAliases",
      "kafka:ListClustersV2",
      "kinesis:DescribeStream",
      "kinesis:ListShards",
      "kinesis:ListStreams",
      "kinesis:ListTagsForStream",
      "lambda:ListEventSourceMappings",
      "lambda:ListFunctions",
      "lambda:ListTags",
      "network-firewall:ListFirewalls",
      "network-firewall:DescribeFirewall",
      "redshift:DescribeClusters",
      "rds:DescribeDBClusters",
      "rds:DescribeDBInstances",
      "rds:DescribeDBProxies",
      "rds:ListTagsForResource",
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource",
      "s3:GetBucketLocation",
      "s3:GetBucketNotification",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketTagging",
      "s3:GetEncryptionConfiguration",
      "s3:ListAllMyBuckets",
      "sns:GetSubscriptionAttributes",
      "sns:GetTopicAttributes",
      "sns:ListSubscriptions",
      "sns:ListTopics",
      "sns:ListTagsForResource",
      "sqs:GetQueueAttributes",
      "sqs:ListQueues",
      "sqs:ListQueueTags",
      "states:DescribeActivity",
      "states:ListActivities",
      "states:DescribeStateMachine",
      "states:ListStateMachines",
      "states:ListTagsForResource",
      "sts:GetCallerIdentity"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_policy" "import_policy" {
  name        = var.policy_name
  description = "Policy to allow Lucid to import AWS accounts"
  policy      = data.aws_iam_policy_document.import.json
}

resource "aws_iam_role_policy_attachment" "import_policy_attachment" {
  role       = aws_iam_role.import_role.name
  policy_arn = aws_iam_policy.import_policy.arn
}
