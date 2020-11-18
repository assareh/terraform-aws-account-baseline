# Roles and policies for Redlock

# Redlock trust policy
data "aws_iam_policy_document" "redlock_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [var.redlock_aws_account_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.redlock_id]
    }

    effect = "Allow"
  }
}

# Redlock Read Only Policy
data "aws_iam_policy_document" "abc_redlock_read_only" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "acm:List*",
      "apigateway:GET",
      "appstream:Describe*",
      "cloudtrail:GetEventSelectors",
      "cloudtrail:LookupEvents",
      "cloudsearch:Describe*",
      "dynamodb:DescribeTable",
      "ds:Describe*",
      "elasticache:List*",
      "eks:List*",
      "eks:Describe*",
      "elasticfilesystem:Describe*",
      "elasticmapreduce:Describe*",
      "elasticmapreduce:List*",
      "inabcctor:Describe*",
      "inabcctor:List*",
      "glacier:List*",
      "glacier:GetVaultAccessPolicy",
      "glacier:GetVaultNotifications",
      "glacier:GetVaultLock",
      "glacier:GetDataRetrievalPolicy",
      "guardduty:List*",
      "guardduty:Get*",
      "iam:SimulatePrincipalPolicy",
      "iam:SimulateCustomPolicy",
      "kinesis:Describe*",
      "kinesis:List*",
      "rds:ListTagsForResource",
      "sns:List*",
      "sns:Get*",
      "sqs:SendMessage",
      "logs:FilterLogEvents",
      "logs:Get*",
      "logs:Describe*",
      "secretsmanager:List*",
      "secretsmanager:Describe*",
      "lambda:List*",
      "s3:GetAccountPublicAccessBlock",
      "s3:GetBucketPublicAccessBlock"
    ]
  }
}

resource "aws_iam_policy" "abc_redlock_read_only" {
  name        = "abc_RedlockReadOnly"
  description = "This grants read only access for the Redlock service"
  policy      = data.aws_iam_policy_document.abc_redlock_read_only.json
}

resource "aws_iam_role" "abc_redlock_read_only" {
  name               = "abcRedlockReadOnly"
  assume_role_policy = data.aws_iam_policy_document.redlock_assume_role_policy.json
  description        = "Read only access for Redlock"
}

resource "aws_iam_role_policy_attachment" "abc_redlock_read_only_AWS1" {
  role       = aws_iam_role.abc_redlock_read_only.name
  policy_arn = data.aws_iam_policy.SecurityAudit.arn
}

resource "aws_iam_role_policy_attachment" "abc_redlock_read_only" {
  role       = aws_iam_role.abc_redlock_read_only.name
  policy_arn = aws_iam_policy.abc_redlock_read_only.arn
}
