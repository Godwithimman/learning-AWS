# modules/iam_groups/variables.tf

variable "iam_groups" {
  description = "Map of groups with their managed policy ARNs"
  type = map(object({
    managed_policy_arns = list(string)
    description         = string
  }))
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "mfa_enforcement_policy_arn" {
  description = "ARN of the MFA enforcement policy to attach to all groups"
  type        = string
}

variable "developer_custom_policy_arn" {
  description = "ARN of the custom developer policy"
  type        = string
}

variable "devops_custom_policy_arn" {
  description = "ARN of the custom DevOps policy"
  type        = string
}
