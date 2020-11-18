# output "account_alias" {
#   description = "Account alias"
#   value       = aws_iam_account_alias.alias.account_alias
# }

output "baseline_version" {
  description = "Version of the baseline module"
  value       = local.baseline_version
}

output "developer_role" {
  description = "ARN for developer role"
  value       = module.iam-policy.developer
}