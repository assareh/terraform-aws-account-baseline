# Okta assume role policy
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["*"]
    }

    effect = "Allow"
  }
}
