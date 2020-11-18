# Roles and policies for secops Splunk

# secops Monitoring Splunk assume role policy
data "aws_iam_policy_document" "secops_monitoring_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

# secops Monitoring Splunk read only policy
data "aws_iam_policy_document" "secops_aws_monitoring_role" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "sqs:GetQueueAttributes",
      "sqs:ListQueues",
      "sqs:GetQueueUrl",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:ListAllMyBuckets",
      "s3:GetBucketTagging",
      "s3:GetAccelerateConfiguration",
      "s3:GetBucketLogging",
      "s3:GetLifecycleConfiguration",
      "s3:GetBucketCORS",
      "config:DeliverConfigSnapshot",
      "config:DescribeConfigRules",
      "config:DescribeConfigRuleEvaluationStatus",
      "config:GetComplianceDetailsByConfigRule",
      "config:GetComplianceSummaryByConfigRule",
      "iam:GetUser",
      "iam:ListUsers",
      "iam:GetAccountPasswordPolicy",
      "iam:ListAccessKeys",
      "iam:GetAccessKeyLastUsed",
      "autoscaling:Describe*",
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "sns:Get*",
      "sns:List*",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:GetLogEvents",
      "ec2:DescribeInstances",
      "ec2:DescribeReservedInstances",
      "ec2:DescribeSnapshots",
      "ec2:DescribeRegions",
      "ec2:DescribeKeyPairs",
      "ec2:DescribeNetworkAcls",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVolumes",
      "ec2:DescribeVpcs",
      "ec2:DescribeImages",
      "ec2:DescribeAddresses",
      "lambda:ListFunctions",
      "rds:DescribeDBInstances",
      "cloudfront:ListDistributions",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeInstanceHealth",
      "elasticloadbalancing:DescribeTags",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:DescribeListeners",
      "inspector:Describe*",
      "inspector:List*",
      "kinesis:DescribeStream",
      "kinesis:ListStreams",
    ]
  }
}

resource "aws_iam_policy" "secops_aws_monitoring_role" {
  name        = "abc_secops_AWS_Monitoring_Role-DescribePolicy"
  description = "This grants read only access for secops Splunk"
  policy      = data.aws_iam_policy_document.secops_aws_monitoring_role.json
}

resource "aws_iam_role" "secops_aws_monitoring_role" {
  name               = "secops_AWS_Monitoring_Role"
  assume_role_policy = data.aws_iam_policy_document.secops_monitoring_assume_role_policy.json
  description        = "Read only access for Splunk"
}

resource "aws_iam_role_policy_attachment" "secops_aws_monitoring_role_AWS1" {
  role       = aws_iam_role.secops_aws_monitoring_role.name
  policy_arn = data.aws_iam_policy.SecurityAudit.arn
}

resource "aws_iam_role_policy_attachment" "secops_aws_monitoring_role" {
  role       = aws_iam_role.secops_aws_monitoring_role.name
  policy_arn = aws_iam_policy.secops_aws_monitoring_role.arn
}
