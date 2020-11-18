terraform-aws-account-baseline
==============================
Overview
--------
This module provides a baseline configuration for AWS accounts (Sandbox and Developer excluded).  The module itself is called from a Terraform Enterprise workspace dedicated to each specific account.


Process
-------
The baseline process is made up of the following steps:

1. Connect to the TFE backend for core-logging in order to retrieve S3 bucket details
2. Set the AWS Account Alias based off of the provided account and account ID
3. Create a local 'terraform' user which will be used to run the TFE workspace provided to the requestor
4. Create Single Sign On identity provider for Okta
5. Configure IAM roles and polices from the iam-policy sub-module
6. Configure required IAM policies for AWS Config
7. Enable AWS Config for US-WEST-2 and US-EAST-1 regions
8. Set IAM Password Policy


Usage
-----
The module expects the following inputs and returns listed outputs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_name | The name for the account | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| account\_alias | Account alias |
| baseline\_version | Version of the baseline module |
