output "account_alias" {
  description = "Account alias"
  value       = aws_iam_account_alias.alias.account_alias
}

output "baseline_version" {
  description = "Version of the baseline module"
  value       = local.baseline_version
}
