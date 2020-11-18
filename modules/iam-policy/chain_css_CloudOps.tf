# CloudOps trust policy
data "aws_iam_policy_document" "CloudOps_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
      ]
    }
  }
}


# CloudOps custom policy
data "aws_iam_policy_document" "CloudOps_denyset" {
  statement {
    effect    = "Deny"
    resources = ["*"]
    actions   = ["sts:*"]
  }
}

# CloudOps role policy
resource "aws_iam_policy" "CloudOps_denyset" {
  name        = "CloudOpsdenyset"
  description = "This denies all assume role capabilities"
  policy      = data.aws_iam_policy_document.CloudOps_denyset.json
}

# CloudOps role
resource "aws_iam_role" "CloudOps_role" {
  name               = "CloudOps"
  assume_role_policy = data.aws_iam_policy_document.CloudOps_assume_role_policy.json
}

# CloudOps role policy attachments
resource "aws_iam_role_policy_attachment" "CloudOps_readonly" {
  role       = aws_iam_role.CloudOps_role.name
  policy_arn = data.aws_iam_policy.ReadOnlyAccess.arn
}

resource "aws_iam_role_policy_attachment" "CloudOps_denyset" {
  role       = aws_iam_role.CloudOps_role.name
  policy_arn = aws_iam_policy.CloudOps_denyset.arn
}
