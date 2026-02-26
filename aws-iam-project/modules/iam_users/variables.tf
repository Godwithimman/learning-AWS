# modules/iam_users/variables.tf

variable "iam_users" {
  description = "Map of IAM users to create"
  type = map(object({
    groups               = list(string)
    tags                 = map(string)
    create_login_profile = bool
    force_destroy        = bool
  }))
}

variable "group_names" {
  description = "Map of group key => actual group name from the groups module"
  type        = map(string)
}

variable "project_name" {
  description = "Project name used in user path"
  type        = string
}

variable "environment" {
  description = "Deployment environment tag"
  type        = string
}
