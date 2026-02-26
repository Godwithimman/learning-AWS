# =============================================================
# variables.tf
# -------------------------------------------------------------
# PURPOSE: Define all input variables for the root module.
#
# 📖 LEARN: Variables make your Terraform code reusable.
#           Instead of hardcoding values, you pass them in.
#           Think of variables like function parameters.
# =============================================================

# ----------------------------
# General Settings
# ----------------------------

variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-east-1"

  # Validation block — prevents invalid values
  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]{1}$", var.aws_region))
    error_message = "Must be a valid AWS region format (e.g., us-east-1, ap-south-1)."
  }
}

variable "environment" {
  description = "Deployment environment: dev, staging, or prod"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "owner" {
  description = "Name or email of the person/team who owns this infrastructure"
  type        = string
  default     = "cloud-team"
}

variable "project_name" {
  description = "Name of the project (used in resource names)"
  type        = string
  default     = "iam-learning-project"
}

# ----------------------------
# Password Policy Settings
# ----------------------------

variable "password_min_length" {
  description = "Minimum length for IAM user passwords"
  type        = number
  default     = 12

  validation {
    condition     = var.password_min_length >= 8
    error_message = "Password minimum length must be at least 8 characters."
  }
}

variable "password_max_age" {
  description = "Number of days before password expiration (0 = never expire)"
  type        = number
  default     = 90
}

variable "password_reuse_prevention" {
  description = "How many previous passwords cannot be reused"
  type        = number
  default     = 5
}

# ----------------------------
# IAM Users
# ----------------------------

variable "iam_users" {
  description = "Map of IAM users to create with their group memberships"
  type = map(object({
    groups      = list(string)  # Which groups this user belongs to
    tags        = map(string)   # Extra metadata tags
    create_login_profile = bool # Allow AWS Console login?
    force_destroy        = bool # Allow deletion even if user has resources?
  }))

  default = {
    "alice.admin" = {
      groups               = ["admins"]
      tags                 = { Role = "Cloud Administrator", Team = "Platform" }
      create_login_profile = true
      force_destroy        = true
    }
    "bob.devops" = {
      groups               = ["devops", "developers"]
      tags                 = { Role = "DevOps Engineer", Team = "Platform" }
      create_login_profile = true
      force_destroy        = true
    }
    "carol.dev" = {
      groups               = ["developers"]
      tags                 = { Role = "Backend Developer", Team = "Engineering" }
      create_login_profile = true
      force_destroy        = true
    }
    "dave.dev" = {
      groups               = ["developers"]
      tags                 = { Role = "Frontend Developer", Team = "Engineering" }
      create_login_profile = true
      force_destroy        = true
    }
    "eve.security" = {
      groups               = ["security", "readonly"]
      tags                 = { Role = "Security Analyst", Team = "Security" }
      create_login_profile = true
      force_destroy        = true
    }
    "frank.billing" = {
      groups               = ["billing"]
      tags                 = { Role = "Finance Manager", Team = "Finance" }
      create_login_profile = true
      force_destroy        = true
    }
    "grace.readonly" = {
      groups               = ["readonly"]
      tags                 = { Role = "Intern", Team = "Engineering" }
      create_login_profile = true
      force_destroy        = true
    }
    "henry.devops" = {
      groups               = ["devops"]
      tags                 = { Role = "SRE Engineer", Team = "Platform" }
      create_login_profile = true
      force_destroy        = true
    }
    "iris.dev" = {
      groups               = ["developers"]
      tags                 = { Role = "Full-Stack Developer", Team = "Engineering" }
      create_login_profile = true
      force_destroy        = true
    }
    "jake.readonly" = {
      groups               = ["readonly"]
      tags                 = { Role = "Business Analyst", Team = "Product" }
      create_login_profile = true
      force_destroy        = true
    }
  }
}

# ----------------------------
# IAM Groups
# ----------------------------

variable "iam_groups" {
  description = "Map of IAM groups and the AWS managed policies to attach"
  type = map(object({
    managed_policy_arns = list(string)  # AWS pre-built policy ARNs
    description         = string        # Human-readable description
  }))

  default = {
    "admins" = {
      description         = "Full administrative access to all AWS services"
      managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    }
    "developers" = {
      description         = "Access to common developer services: EC2, S3, Lambda, RDS, CloudWatch"
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/PowerUserAccess"
      ]
    }
    "devops" = {
      description         = "Infrastructure management and CI/CD pipeline access"
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/PowerUserAccess",
        "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
      ]
    }
    "readonly" = {
      description         = "Read-only access to all AWS services (for auditors and interns)"
      managed_policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
    }
    "security" = {
      description         = "Security auditing: CloudTrail, GuardDuty, Security Hub, Config"
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/SecurityAudit",
        "arn:aws:iam::aws:policy/AmazonGuardDutyReadOnlyAccess"
      ]
    }
    "billing" = {
      description         = "AWS billing and cost management access"
      managed_policy_arns = ["arn:aws:iam::aws:policy/job-function/Billing"]
    }
  }
}
