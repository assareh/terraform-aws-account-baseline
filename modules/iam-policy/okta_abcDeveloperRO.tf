# Assumerole policy data in shared_assumerole.tf

# abcDeveloperRO custom policy - Denyset
data "aws_iam_policy_document" "abc_developerRO_denyset" {
  statement {
    effect    = "Deny"
    resources = ["*"]
    actions   = ["organizations:*"]
  }
}

# Deny Billing
data "aws_iam_policy_document" "deny_billing" {
  statement {
    effect    = "Deny"
    resources = ["*"]
    actions   = ["aws-portal:*Account"]
  }
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions   = ["aws-portal:ViewAccount", "aws-portal:ViewBilling", "aws-portal:ViewUsage"]
  }

}

# abcDeveloperRO role policy
resource "aws_iam_policy" "abc_developerRO_denyset" {
  name        = "abc_developerROdenyset"
  description = "This denies all IAM and Organizational operations"
  policy      = data.aws_iam_policy_document.abc_developerRO_denyset.json
}

resource "aws_iam_policy" "abc_deny_billing" {
  name        = "abc_deny_billing"
  description = "This denies billing access"
  policy      = data.aws_iam_policy_document.deny_billing.json
}

# abcDeveloperRO role
resource "aws_iam_role" "abc_developerRO_role" {
  name               = "abcDeveloperRO"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

# abcDeveloperRO role policy attachments
resource "aws_iam_role_policy_attachment" "abc_developerRO_ReadOnlyAccess_attach" {
  role       = aws_iam_role.abc_developerRO_role.name
  policy_arn = data.aws_iam_policy.ReadOnlyAccess.arn
}

resource "aws_iam_role_policy_attachment" "abc_developerRO_iam_Org_attach" {
  role       = aws_iam_role.abc_developerRO_role.name
  policy_arn = aws_iam_policy.abc_developerRO_denyset.arn
}

resource "aws_iam_role_policy_attachment" "abc_developerRO_billing_attach" {
  role       = aws_iam_role.abc_developerRO_role.name
  policy_arn = aws_iam_policy.abc_deny_billing.arn
}
