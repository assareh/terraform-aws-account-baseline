# Make baseline module version available
locals {
  baseline_version = "v1.4.6"
}

# Connect to the core-logging account to get S3 buckets
# data "terraform_remote_state" "logging" {
#   backend = "atlas"

#   config {
#     name    = "CloudOps/baseline-core-logging"
#     address = "https://tfe.hosting.com"
#   }
# }

# Get the access to the effective Account ID in which Terraform is working.
data "aws_caller_identity" "current" {}

# Set account alias with name and account ID
# resource "aws_iam_account_alias" "alias" {
#   account_alias = "${var.account_name}-${data.aws_caller_identity.current.account_id}"
# }

# Create the local Terraform user
# resource "aws_iam_user" "terraform" {
#   name          = "terraform"
#   force_destroy = true
# }

# resource "aws_iam_user_policy_attachment" "terraform_user_policy" {
#   user       = aws_iam_user.terraform.name
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# }

# Okta provider - App Production
# resource "aws_iam_saml_provider" "okta_prd" {
#   name                   = "OKTA_PRD"
#   count                  = var.int_environment == "prd" ? 1 : 0
#   saml_metadata_document = file("${path.module}/files/okta-prd.xml")
# }

# Okta provider - App Non-Production
# resource "aws_iam_saml_provider" "okta_npd" {
#   name                   = "OKTA_NPD"
#   count                  = var.int_environment == "npd" ? 1 : 0
#   saml_metadata_document = file("${path.module}/files/okta-npd.xml")
# }

# Roles and policies
module "iam-policy" {
  source = "./modules/iam-policy"
  # okta_provider_arn = "${aws_iam_saml_provider.okta_sso.arn}"
  # okta_provider_arn = "${element(concat(aws_iam_saml_provider.okta_prd.*.arn, aws_iam_saml_provider.okta_npd.*.arn, list("")), 0)}"
}

# AWS Config
# module "aws_config_iam" {
#   source             = "modules/aws-config-iam"
#   config_logs_bucket = data.terraform_remote_state.logging.s3_config_logs
# }

# module "aws_config_service_west-2" {
#   source             = "modules/aws-config-service"
#   config_logs_bucket = data.terraform_remote_state.logging.s3_config_logs
#   aws_iam_role_arn   = module.aws_config_iam.aws_iam_role_arn

#   providers = {
#     aws = "aws.us-west-2"
#   }
# }

# module "aws_config_service_east-1" {
#   source                        = "modules/aws-config-service"
#   config_logs_bucket            = data.terraform_remote_state.logging.s3_config_logs
#   aws_iam_role_arn              = module.aws_config_iam.aws_iam_role_arn
#   include_global_resource_types = true

#   providers = {
#     aws = "aws.us-east-1"
#   }
# }

# IAM account password policy
# resource "aws_iam_account_password_policy" "priviliged" {
#   minimum_password_length        = 16
#   require_lowercase_characters   = true
#   require_numbers                = true
#   require_uppercase_characters   = true
#   require_symbols                = true
#   allow_users_to_change_password = true
#   max_password_age               = 90
#   password_reuse_prevention      = 24
# }

provider "tfe" {
  version = "~> 0.15.0"
}
  
# required variables for application workspace
resource "tfe_variable" "role_arn" {
  key          = "role_arn"
  value        = module.iam-policy.developer
  category     = "terraform"
  workspace_id = data.tfe_workspace.application.id
  description  = "The AWS IAM role to assume"
}

data "tfe_workspace" "application" {
  name         = "${var.account_name}-resources"
  organization = var.tfc_org
}
