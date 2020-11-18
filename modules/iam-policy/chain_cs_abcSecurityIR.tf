# abcBreakGlass trust policy
data "aws_iam_policy_document" "abcSecurityIR_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::111111111111:role/abcSecurityIR",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
      ]
    }
  }
}

#AWS Managed policy for systemadministrator
data "aws_iam_policy" "SystemAdministrator" {
  arn = "arn:aws:iam::aws:policy/job-function/SystemAdministrator"
}

# abcSecurityIR role
resource "aws_iam_role" "abc_abcSecurityIR_role" {
  name               = "abcSecurityIR"
  assume_role_policy = data.aws_iam_policy_document.abcSecurityIR_assume_role_policy.json
}

# abcSecurityIR role policy attachments
resource "aws_iam_role_policy_attachment" "abcSecurityIR_SystemAdministrator_attach" {
  role       = aws_iam_role.abc_abcSecurityIR_role.name
  policy_arn = data.aws_iam_policy.SystemAdministrator.arn
}
