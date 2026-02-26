# modules/iam_policies/outputs.tf
# These outputs are used by other modules (groups, roles)

output "mfa_enforcement_policy_arn" {
  description = "ARN of the MFA enforcement policy"
  value       = aws_iam_policy.enforce_mfa.arn
}

output "developer_custom_policy_arn" {
  description = "ARN of the developer custom policy"
  value       = aws_iam_policy.developer_custom.arn
}

output "devops_custom_policy_arn" {
  description = "ARN of the DevOps custom policy"
  value       = aws_iam_policy.devops_custom.arn
}

output "s3_readonly_policy_arn" {
  description = "ARN of the S3 read-only policy"
  value       = aws_iam_policy.s3_readonly_project.arn
}

output "all_policy_arns" {
  description = "Map of all custom policy ARNs"
  value = {
    mfa_enforcement  = aws_iam_policy.enforce_mfa.arn
    developer_custom = aws_iam_policy.developer_custom.arn
    devops_custom    = aws_iam_policy.devops_custom.arn
    s3_readonly      = aws_iam_policy.s3_readonly_project.arn
  }
}
