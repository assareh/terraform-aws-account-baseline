variable "okta_provider_arn" {
  description = "The ARN of the Okta provider for the account being provisioned."
}

variable "redlock_aws_account_arn" {
  description = "The ARN of the account used by Redlock service to view resources"
  default     = "arn:aws:iam::111111111111:root"
}

variable "redlock_id" {
  description = "The value entered into Redlock to provide an extra layer of security validation"
  default     = "abc-redlock"
}

variable "secops_monitoring_aws_account_arn" {
  description = "The ARN of the role used by secops Splunk to view resources"
  default     = "arn:aws:iam::111111111111:role/splunk_ec2_api_server_role"
}
