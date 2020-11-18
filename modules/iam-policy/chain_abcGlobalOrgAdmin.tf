# abcGlobalOrgAdmin assume role policy
data "aws_iam_policy_document" "orgadm_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::<org-master-aws-account-number>:root",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
      ]
    }
  }
}

# abcGlobalOrgAdmin managed policy
data "aws_iam_policy" "AWSOrgFullAccess" {
  arn = "arn:aws:iam::aws:policy/AWSOrganizationsFullAccess"
}

# abcGlobalOrgAdmin role
resource "aws_iam_role" "abcGlobalOrgAdmin_role" {
  name               = "abcGlobalOrgAdmin"
  assume_role_policy = data.aws_iam_policy_document.orgadm_assume_role_policy.json
}

# abcGlobalOrgAdmin policy attachments
resource "aws_iam_role_policy_attachment" "abc_abcGlobalOrgAdmin_fullaccess" {
  role       = aws_iam_role.abcGlobalOrgAdmin_role.name
  policy_arn = data.aws_iam_policy.AWSOrgFullAccess.arn
}
