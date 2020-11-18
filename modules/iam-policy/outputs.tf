output "administrator_access" {
  description = "IAM policy document for AdministratorAccess role"
  value       = data.aws_iam_policy.AdministratorAccess.policy
}
# output "power_user_access" {
#   description = "IAM policy document for PowerUserAccess role"
#   value       = "${data.aws_iam_policy.PowerUserAccess.policy}"
# }
output "security_audit" {
  description = "IAM policy document for SecurityAudit role"
  value       = data.aws_iam_policy.SecurityAudit.policy
}
# output "dba" {
#   description = "IAM policy document for DBA role"
#   value       = "${data.aws_iam_policy.AmazonRDSFullAccess.policy}"
# }

output "developer" {
  description = "ARN for Developer role"
  value       = aws_iam_role.abc_developerRO_role.arn
}
