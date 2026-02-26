# modules/iam_policies/variables.tf

variable "project_name" {
  description = "Project name prefix for policy names"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}
