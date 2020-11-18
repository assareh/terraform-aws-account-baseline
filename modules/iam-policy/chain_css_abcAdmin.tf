#CloudOps trust policy
data "aws_iam_policy_document" "Admin_assume_role_policy" {
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

# Developer custom policies
data "aws_iam_policy_document" "Admin_denyset" {
  statement {
    effect    = "Deny"
    resources = ["*"]
    actions   = ["aws-portal:*"]
  }

  statement {
    effect    = "Deny"
    resources = ["*"]

    actions = [
      "kms:CancelKeyDeletion",
      "kms:DeleteAlias",
      "kms:DeleteImportedKeyMaterial",
      "kms:DisableKey",
      "kms:DisableKeyRotation",
      "kms:RetireGrant",
      "kms:UntagResource",
    ]
  }
}

# Admin role policy
resource "aws_iam_policy" "abc_Admin_denyset_policy" {
  name        = "abc_Admindenyset"
  description = "Deny set for Admin role"
  policy      = data.aws_iam_policy_document.Admin_denyset.json
}

# Admin role
resource "aws_iam_role" "Admin_role" {
  name               = "Admin"
  assume_role_policy = data.aws_iam_policy_document.Admin_assume_role_policy.json
}

# Admin role policy attachments
resource "aws_iam_role_policy_attachment" "Admin_role_administrator_attach" {
  role       = aws_iam_role.Admin_role.name
  policy_arn = data.aws_iam_policy.AdministratorAccess.arn
}

resource "aws_iam_role_policy_attachment" "Admin_role_denyset_attach" {
  role       = aws_iam_role.Admin_role.name
  policy_arn = aws_iam_policy.abc_Admin_denyset_policy.arn
}
