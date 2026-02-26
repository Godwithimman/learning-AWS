# modules/iam_roles/variables.tf

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "developer_custom_policy_arn" {
  description = "ARN of custom developer policy (used in cross-account role)"
  type        = string
}
