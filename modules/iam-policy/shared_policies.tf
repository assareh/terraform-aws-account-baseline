######################
# AWS Managed shared Policies

# Administrator access policy
data "aws_iam_policy" "AdministratorAccess" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# ReadOnlyAccess managed policy
data "aws_iam_policy" "ReadOnlyAccess" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# SecurityAudit managed policy
data "aws_iam_policy" "SecurityAudit" {
  arn = "arn:aws:iam::aws:policy/SecurityAudit"
}
