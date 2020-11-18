# abcBreakGlass trust policy
# abcBreakGlass trust policy
data "aws_iam_policy_document" "breakglass_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::111111111111:user/BreakglassUser",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
      ]
    }
  }
}

data "aws_iam_policy_document" "breakglass_child_user_policy" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "iam:AddUserToGroup",
      "iam:AttachUserPolicy",
      "iam:CreateUser",
      "iam:GetGroup",
      "iam:GetGroupPolicy",
      "iam:GetPolicy",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:GetUser",
      "iam:ListAttachedGroupPolicies",
      "iam:ListAttachedUserPolicies",
      "iam:ListGroupPolicies",
      "iam:ListGroups",
      "iam:ListGroupsForUser",
      "iam:ListPolicies",
      "iam:ListRolePolicies",
      "iam:ListRoles",
      "iam:ListUserPolicies",
      "iam:ListUsers",
    ]
  }
}

#abcBreakGlass child account policy
resource "aws_iam_policy" "breakglass_child_policy" {
  name        = "abc_breakglass_child_user_policy"
  description = "This grants the required permissions for core breakglass account user in child accounts"
  policy      = data.aws_iam_policy_document.breakglass_child_user_policy.json
}

# abcBreakGlass child user role
resource "aws_iam_role" "breakglass_role" {
  name               = "abcBreakglass"
  assume_role_policy = data.aws_iam_policy_document.breakglass_assume_role_policy.json
  description        = "Role for breakglass role in child accounts"
}

# abcBreakGlass role policy attachments
resource "aws_iam_role_policy_attachment" "breakglass_role_attach" {
  role       = aws_iam_role.breakglass_role.name
  policy_arn = aws_iam_policy.breakglass_child_policy.arn
}
