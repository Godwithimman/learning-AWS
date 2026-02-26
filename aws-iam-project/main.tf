# =============================================================
# main.tf  (Root Module)
# -------------------------------------------------------------
# PURPOSE: This is the ENTRY POINT of the Terraform project.
#          It calls all child modules and wires them together.
#
# 📖 LEARN: In Terraform, a "module" is like a function in
#           programming — it groups related resources together
#           and can be reused. This file calls each module.
#
# FLOW:
#   main.tf
#     ├── module.iam_password_policy   → Sets account-wide password rules
#     ├── module.iam_policies          → Creates custom JSON policies
#     ├── module.iam_groups            → Creates groups + attaches policies
#     ├── module.iam_users             → Creates users + adds to groups
#     └── module.iam_roles             → Creates service roles (for EC2, Lambda, etc.)
# =============================================================


# -----------------------------------------------------------
# 1. ACCOUNT PASSWORD POLICY
# -----------------------------------------------------------
# This sets rules for ALL IAM user passwords in this account.
# It's a best practice to enforce strong passwords.
# -----------------------------------------------------------

resource "aws_iam_account_password_policy" "main" {
  # Minimum number of characters required
  minimum_password_length = var.password_min_length

  # Must contain at least one UPPERCASE letter (A-Z)
  require_uppercase_characters = true

  # Must contain at least one LOWERCASE letter (a-z)
  require_lowercase_characters = true

  # Must contain at least one number (0-9)
  require_numbers = true

  # Must contain at least one symbol (!@#$%^&*)
  require_symbols = true

  # Do NOT allow users to change their own password
  # Set to true in production to let users manage their own passwords
  allow_users_to_change_password = true

  # Password expires after X days
  max_password_age = var.password_max_age

  # Cannot reuse their last X passwords
  password_reuse_prevention = var.password_reuse_prevention

  # Lock account after failed login attempts? (true = hard expiry)
  hard_expiry = false
}


# -----------------------------------------------------------
# 2. CUSTOM IAM POLICIES MODULE
# -----------------------------------------------------------
# Creates custom JSON policies that aren't available as
# AWS Managed Policies (the built-in ones).
# -----------------------------------------------------------

module "iam_policies" {
  source = "./modules/iam_policies"

  project_name = var.project_name
  environment  = var.environment
}


# -----------------------------------------------------------
# 3. IAM GROUPS MODULE
# -----------------------------------------------------------
# Creates all groups and attaches the correct policies.
# Groups are the recommended way to manage permissions —
# never attach policies directly to individual users!
# -----------------------------------------------------------

module "iam_groups" {
  source = "./modules/iam_groups"

  iam_groups   = var.iam_groups
  project_name = var.project_name

  # Pass in the custom policy ARNs created by the policies module
  mfa_enforcement_policy_arn    = module.iam_policies.mfa_enforcement_policy_arn
  developer_custom_policy_arn   = module.iam_policies.developer_custom_policy_arn
  devops_custom_policy_arn      = module.iam_policies.devops_custom_policy_arn

  # Groups module depends on policies being created first
  depends_on = [module.iam_policies]
}


# -----------------------------------------------------------
# 4. IAM USERS MODULE
# -----------------------------------------------------------
# Creates all IAM users and assigns them to their groups.
# Each user gets a randomly generated temporary password
# that must be changed on first login.
# -----------------------------------------------------------

module "iam_users" {
  source = "./modules/iam_users"

  iam_users    = var.iam_users
  project_name = var.project_name
  environment  = var.environment

  # Pass in group names so users can be assigned to them
  group_names = module.iam_groups.group_names

  # Users depend on groups existing first
  depends_on = [module.iam_groups]
}


# -----------------------------------------------------------
# 5. IAM ROLES MODULE
# -----------------------------------------------------------
# Creates roles that AWS services (EC2, Lambda, ECS) use
# to interact with other AWS services.
#
# 📖 LEARN: Roles are for MACHINES. Users are for HUMANS.
#           An EC2 instance uses a role to read from S3.
#           A developer uses a user account to login to console.
# -----------------------------------------------------------

module "iam_roles" {
  source = "./modules/iam_roles"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  # ARN of the custom developer policy for cross-account role
  developer_custom_policy_arn = module.iam_policies.developer_custom_policy_arn

  depends_on = [module.iam_policies]
}
