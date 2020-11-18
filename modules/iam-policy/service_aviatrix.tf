# Roles and policies for Aviatrix

##############
# Aviatrix EC2
# Aviatrix EC2 trust policy
data "aws_iam_policy_document" "aviatrix_ec2_trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Aviatrix EC2 role policy
data "aws_iam_policy_document" "aviatrix_ec2_role_policy" {
  statement {
    effect    = "Allow"
    resources = ["arn:aws:iam::*:role/aviatrix-*"]
    actions   = ["sts:AssumeRole"]
  }

  statement {
    effect    = "Allow"
    resources = ["*"]
    actions   = ["aws-marketplace:MeterUsage"]
  }
}

# Aviatrix EC2 role policy
resource "aws_iam_policy" "aviatrix_ec2_role_policy" {
  name        = "aviatrix-assume-role-policy"
  description = "This allows EC2 instances to assume IAM roles and access Meter Usage"
  policy      = data.aws_iam_policy_document.aviatrix_ec2_role_policy.json
}

# Aviatrix EC2 role
resource "aws_iam_role" "aviatrix_ec2_role" {
  name               = "aviatrix-role-ec2"
  assume_role_policy = data.aws_iam_policy_document.aviatrix_ec2_trust_policy.json
  description        = "Aviatrix role for EC2"
}

# Aviatrix EC2 role policy attachment
resource "aws_iam_role_policy_attachment" "aviatrix_ec2_role" {
  role       = aws_iam_role.aviatrix_ec2_role.name
  policy_arn = aws_iam_policy.aviatrix_ec2_role_policy.arn
}

# Attach Instance profile to Aviatrix EC2 role
resource "aws_iam_instance_profile" "aviatrix_profile" {
  name = "aviatrix-role-ec2"
  role = aws_iam_role.aviatrix_ec2_role.name
}

##############
# Aviatrix App
# Aviatrix App trust policy
data "aws_iam_policy_document" "aviatrix_app_trust_policy" {
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

# Aviatrix App role policy
data "aws_iam_policy_document" "aviatrix_app_role_policy" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:Get*",
      "ec2:Describe*",
      "ec2:Search*",
      "elasticloadbalancing:Describe*",
      "route53:List*",
      "route53:Get*",
      "sqs:Get*",
      "sqs:List*",
      "sns:List*",
      "s3:List*",
      "s3:Get*",
      "iam:List*",
      "iam:Get*",
      "directconnect:Describe*",
      "guardduty:Get*",
      "guardduty:List*",
      "ram:Get*",
      "ram:List*",
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["*"]
    actions   = ["ec2:RunInstances"]
  }

  statement {
    effect    = "Allow"
    resources = ["arn:aws:ec2:*:*:image/ami-*"]
    actions   = ["ec2:RunInstances"]
  }

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:DeleteSecurityGroup",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:AuthorizeSecurityGroup*",
      "ec2:CreateSecurityGroup",
      "ec2:AssociateRouteTable",
      "ec2:CreateRoute",
      "ec2:CreateRouteTable",
      "ec2:DeleteRoute",
      "ec2:DeleteRouteTable",
      "ec2:DisassociateRouteTable",
      "ec2:ReplaceRoute",
      "ec2:ReplaceRouteTableAssociation",
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:AllocateAddress",
      "ec2:AssociateAddress",
      "ec2:DisassociateAddress",
      "ec2:ReleaseAddress",
      "ec2:AssignPrivateIpAddresses",
      "ec2:AttachNetworkInterface",
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DetachNetworkInterface",
      "ec2:ModifyNetworkInterfaceAttribute",
      "ec2:ResetNetworkInterfaceAttribute",
      "ec2:UnassignPrivateIpAddresses",
      "ec2:ModifyInstanceAttribute",
      "ec2:MonitorInstances",
      "ec2:RebootInstances",
      "ec2:ReportInstanceStatus",
      "ec2:ResetInstanceAttribute",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:TerminateInstances",
      "ec2:UnmonitorInstances",
      "ec2:AttachInternetGateway",
      "ec2:CreateInternetGateway",
      "ec2:DeleteInternetGateway",
      "ec2:DetachInternetGateway",
      "ec2:CreateKeyPair",
      "ec2:DeleteKeyPair",
      "ec2:CreateSubnet",
      "ec2:DeleteSubnet",
      "ec2:ModifySubnetAttribute",
      "ec2:CreateTags",
      "ec2:DeleteTags",
      "ec2:CreateVpc",
      "ec2:DeleteVpc",
      "ec2:ModifyVpcAttribute",
      "ec2:CreateCustomerGateway",
      "ec2:DeleteCustomerGateway",
      "ec2:CreateVpnConnection",
      "ec2:DeleteVpnConnection",
      "ec2:CreateVpcPeeringConnection",
      "ec2:AcceptVpcPeeringConnection",
      "ec2:DeleteVpcPeeringConnection",
      "ec2:ModifyInstanceCreditSpecification",
      "ec2:CreateNetworkAclEntry",
      "ec2:ReplaceNetworkAclEntry",
      "ec2:DeleteNetworkAclEntry",
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:AssociateTransitGatewayRouteTable",
      "ec2:AcceptTransitGatewayVpcAttachment",
      "ec2:CreateTransitGateway",
      "ec2:CreateTransitGatewayRoute",
      "ec2:CreateTransitGatewayRouteTable",
      "ec2:CreateTransitGatewayVpcAttachment",
      "ec2:DeleteTransitGateway",
      "ec2:DeleteTransitGatewayRoute",
      "ec2:DeleteTransitGatewayRouteTable",
      "ec2:DeleteTransitGatewayVpcAttachment",
      "ec2:DisableTransitGatewayRouteTablePropagation",
      "ec2:DisassociateTransitGatewayRouteTable",
      "ec2:EnableTransitGatewayRouteTablePropagation",
      "ec2:EnableRoutePropagation",
      "ec2:ExportTransitGatewayRoutes",
      "ec2:ModifyTransitGatewayVpcAttachment",
      "ec2:RejectTransitGatewayVpcAttachment",
      "ec2:ReplaceTransitGatewayRoute",
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ram:CreateResourceShare",
      "ram:DeleteResourceShare",
      "ram:UpdateResourceShare",
      "ram:AssociateResourceShare",
      "ram:DisassociateResourceShare",
      "ram:TagResource",
      "ram:UntagResource",
      "ram:AcceptResourceShareInvitation",
      "ram:EnableSharingWithAwsOrganization",
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticloadbalancing:ApplySecurityGroupsToLoadBalancer",
      "elasticloadbalancing:AttachLoadBalancerToSubnets",
      "elasticloadbalancing:ConfigureHealthCheck",
      "elasticloadbalancing:CreateLoadBalancer*",
      "elasticloadbalancing:DeleteLoadBalancer*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:SetLoadBalancerPoliciesForBackendServer",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:CreateTargetGroup",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DeleteTargetGroup",
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:DeregisterTargets",
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:CreateHostedZone",
      "route53:DeleteHostedZone",
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "s3:PutObject",
      "s3:DeleteObject",
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "sqs:AddPermission",
      "sqs:ChangeMessageVisibility",
      "sqs:CreateQueue",
      "sqs:DeleteMessage",
      "sqs:DeleteQueue",
      "sqs:PurgeQueue",
      "sqs:ReceiveMessage",
      "sqs:RemovePermission",
      "sqs:SendMessage",
      "sqs:SetQueueAttributes",
      "sqs:TagQueue",
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "iam:PassRole",
      "iam:AddRoleToInstanceProfile",
      "iam:CreateInstanceProfile",
      "iam:DeleteInstanceProfile",
      "iam:RemoveRoleFromInstanceProfile",
      "iam:CreateServiceLinkedRole",
    ]
  }

  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "guardduty:CreateDetector",
      "guardduty:DeleteDetector",
      "guardduty:UpdateDetector",
    ]
  }
}

# Aviatrix App role policy
resource "aws_iam_policy" "aviatrix_app_role_policy" {
  name        = "aviatrix-app-policy"
  description = "Grants rights to the Aviatrix AWS account"
  policy      = data.aws_iam_policy_document.aviatrix_app_role_policy.json
}

# Aviatrix App role
resource "aws_iam_role" "aviatrix_app_role" {
  name               = "aviatrix-role-app"
  assume_role_policy = data.aws_iam_policy_document.aviatrix_app_trust_policy.json
  description        = "Role that grants rights to the Aviatrix AWS account"
}

# Aviatrix App role policy attachment
resource "aws_iam_role_policy_attachment" "aviatrix_app_role" {
  role       = aws_iam_role.aviatrix_app_role.name
  policy_arn = aws_iam_policy.aviatrix_app_role_policy.arn
}
