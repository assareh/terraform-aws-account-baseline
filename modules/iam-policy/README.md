terraform-aws-iam-policy
========================
Terraform AWS Standard ABC IAM roles and policies


What this is
------------
This is a module that creates the "standard" ABC IAM roles and policies based
on the (recommendations of the security team)[https://abccorp.atlassian.net/wiki/spaces/PCAWS/pages/812515360/3.+IAM+Roles+Access].
It does not require any inputs, as everything it needs is already defined.


### This will create the following resources: ###
```
AWS IAM Okta roles:
  * Developer
  * DeveloperRO
  * CloudOps
  * SecurityIR
  * Admin
  * NetworkOps

AWS IAM Service roles:
  * RedlockReadOnly
  * secops_AWS_Monitoring_Role
  * aviatrix-role-ec2
  * aviatrix-role-app
  * BreakGlass
  * GlobalOrgAdmin
  

IAM policies:
  * Admin
  * RedlockReadOnly
  * secops_AWS_Monitoring_Role-DescribePolicy
  * aviatrix-assume-role-policy
  * aviatrix-app-policy
  * DenyExternalNetworking
  * DenyGuardDuty
  * DenyIAM
  * DenyLocalNetworking
  * DenyRoute53Domains
  * DenySecurityGroups
  * DenyVPCPeering
```

<!--BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK-->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| secops\_monitoring\_aws\_account\_arn | The ARN of the role used by secops Splunk to view resources | string | `arn:aws:iam::111111111111:role/splunk_ec2_api_server_role` | no |
| okta\_provider\_arn | The ARN of the Okta provider for the account being provisioned. | string | - | yes |
| redlock\_aws\_account\_arn | The ARN of the account used by Redlock service to view resources | string | `arn:aws:iam::111111111111:root` | no |
| redlock\_id | The value entered into Redlock to provide an extra layer of security validation | string | `abc-redlock` | no |

## Outputs

| Name | Description |
|------|-------------|
| administrator\_access | IAM policy document for AdministratorAccess role |
| dba | IAM policy document for DBA role |
| power\_user\_access | IAM policy document for PowerUserAccess role |
| security\_audit | IAM policy document for SecurityAudit role |
<!--END OF PRE-COMMIT-TERRAFORM DOCS HOOK-->

## Bugs
If you find a bug, report the issue via standard bug reporting process and the
fix will be scheduled according to priority and severity.

## How to contribute
Missing a feature? Here's how you can add it yourself.

1. Open an issue to let the maintainer(s) know you're missing the feature. Who
   knows, it may be almost ready for you to use.
1. If you'll need to add the feature, create a fork of the repo into your
   private space.
1. Create a branch in your private fork and get to work on the new feature.
1. When the feature is looking good, create a pull request from your feature
   branch to the master branch on this repo's main location,
   https://ghe.abchosting.com/TFE-PMR/terraform-aws-crr-s3-log-storage .
   Reference the issue you created in the pull request description.
1. The maintainer(s) will review your pull request and, if no changes are
   required, approve and merge it. This will force a version bump of the module.
1. Once the new version of the module is on the Terraform Enterprise Private
   Registry, you can update the `version` string in your terraform code to get
   access to the new features.
