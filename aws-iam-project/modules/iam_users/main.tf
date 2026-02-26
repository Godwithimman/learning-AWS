# =============================================================
# modules/iam_users/main.tf
# -------------------------------------------------------------
# PURPOSE: Creates IAM users and assigns them to groups.
#
# 📖 LEARN: IAM Users represent real people who need to log
#           in to AWS. Each user gets:
#           - A unique username
#           - A login profile (for Console access)
#           - A temporary password (must be changed on first login)
#           - Group memberships (which define their permissions)
# =============================================================

# -----------------------------------------------------------
# Generate random passwords for each user
# -----------------------------------------------------------
# We never hardcode passwords! Instead, we generate them
# randomly and mark them sensitive so they don't appear in logs.
# -----------------------------------------------------------

resource "random_password" "user_passwords" {
  for_each = var.iam_users

  length           = 16          # 16 character password
  special          = true         # Include special characters
  override_special = "!@#$%^&*()" # Only use these special chars (avoid confusing ones)
  min_upper        = 2            # At least 2 uppercase
  min_lower        = 2            # At least 2 lowercase
  min_numeric      = 2            # At least 2 numbers
  min_special      = 2            # At least 2 special chars
}


# -----------------------------------------------------------
# Create IAM Users
# -----------------------------------------------------------

resource "aws_iam_user" "users" {
  for_each = var.iam_users

  name = each.key  # Username (e.g., "alice.admin")
  path = "/${var.project_name}/"  # Organize users under a path

  # force_destroy: If true, destroys user even if they have:
  # - Access keys
  # - Signing certificates
  # - MFA devices
  force_destroy = each.value.force_destroy

  tags = merge(
    {
      Name        = each.key
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    each.value.tags  # Merge in any user-specific tags
  )
}


# -----------------------------------------------------------
# Create Login Profiles (Console Access)
# -----------------------------------------------------------
# A "login profile" allows the user to log in to the AWS Console
# (the website: console.aws.amazon.com)
#
# Without this, the user can ONLY use the CLI/API with access keys.
# -----------------------------------------------------------

resource "aws_iam_user_login_profile" "profiles" {
  # Only create for users who need console access
  for_each = {
    for username, config in var.iam_users :
    username => config
    if config.create_login_profile == true
  }

  user = aws_iam_user.users[each.key].name

  # Temporary password — user MUST change it on first login
  password = random_password.user_passwords[each.key].result

  # Require password change on first login
  password_reset_required = true

  # Lifecycle: Don't overwrite the password if Terraform runs again
  # (the user may have already changed it)
  lifecycle {
    ignore_changes = [password]
  }

  depends_on = [aws_iam_user.users]
}


# -----------------------------------------------------------
# Add Users to Groups
# -----------------------------------------------------------
# Each user can belong to multiple groups.
# We flatten the user→groups relationship to use for_each.
#
# Example user config:
#   "bob.devops" = { groups = ["devops", "developers"] }
#
# This creates TWO membership resources for bob:
#   1. bob.devops → devops
#   2. bob.devops → developers
# -----------------------------------------------------------

locals {
  # Flatten: Create one entry per (user, group) pair
  user_group_memberships = {
    for pair in flatten([
      for username, config in var.iam_users : [
        for group_name in config.groups : {
          key      = "${username}--${group_name}"
          username = username
          group    = group_name
        }
      ]
    ]) : pair.key => pair
  }
}

resource "aws_iam_user_group_membership" "memberships" {
  for_each = local.user_group_memberships

  user   = aws_iam_user.users[each.value.username].name
  groups = [var.group_names[each.value.group]]

  depends_on = [aws_iam_user.users]
}
