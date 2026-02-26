# =============================================================
# modules/iam_groups/main.tf
# -------------------------------------------------------------
# PURPOSE: Creates IAM Groups and attaches policies to them.
#
# 📖 LEARN: Think of groups like departments in a company:
#   - "IT Department" → gets access to servers
#   - "HR Department" → gets access to employee records
#   - "Finance" → gets access to billing systems
#
# Instead of giving each person permissions one by one,
# you assign them to a group and they inherit all permissions.
# =============================================================

# -----------------------------------------------------------
# Create all IAM Groups dynamically
# -----------------------------------------------------------
# for_each iterates over the iam_groups variable map.
# This creates one group for each entry in the map.
#
# 📖 LEARN: for_each is like a for loop in programming.
#           It creates one resource per item in a map or set.
# -----------------------------------------------------------

resource "aws_iam_group" "all_groups" {
  # for_each creates one resource per entry in iam_groups
  for_each = var.iam_groups

  # each.key = the group name (e.g., "admins", "developers")
  name = each.key

  # Groups can have a "path" — useful for organizing in large orgs
  # /division/team/  format is common
  path = "/${var.project_name}/"
}


# -----------------------------------------------------------
# Attach AWS Managed Policies to Groups
# -----------------------------------------------------------
# Each group can have multiple managed policies.
# We use a "flattening" trick to handle this with for_each.
#
# 📖 LEARN: for_each can't directly handle nested lists,
#           so we flatten the data structure first.
# -----------------------------------------------------------

locals {
  # Flatten the group → policies relationship into a flat map
  # Input:  { "admins" = { policies = ["arn1", "arn2"] } }
  # Output: { "admins-arn1" = { group="admins", arn="arn1" } }
  group_policy_attachments = {
    for pair in flatten([
      for group_name, group_config in var.iam_groups : [
        for policy_arn in group_config.managed_policy_arns : {
          key        = "${group_name}--${replace(policy_arn, ":", "_")}"
          group_name = group_name
          policy_arn = policy_arn
        }
      ]
    ]) : pair.key => pair
  }
}

# Attach each managed policy to its group
resource "aws_iam_group_policy_attachment" "managed_policies" {
  for_each = local.group_policy_attachments

  group      = aws_iam_group.all_groups[each.value.group_name].name
  policy_arn = each.value.policy_arn

  depends_on = [aws_iam_group.all_groups]
}


# -----------------------------------------------------------
# Attach Custom MFA Enforcement Policy to ALL groups
# -----------------------------------------------------------
# Every group gets the MFA policy so that ALL users must
# set up MFA before they can do anything.
# -----------------------------------------------------------

resource "aws_iam_group_policy_attachment" "mfa_all_groups" {
  for_each = var.iam_groups

  group      = aws_iam_group.all_groups[each.key].name
  policy_arn = var.mfa_enforcement_policy_arn

  depends_on = [aws_iam_group.all_groups]
}


# -----------------------------------------------------------
# Attach Developer Custom Policy to "developers" group
# -----------------------------------------------------------

resource "aws_iam_group_policy_attachment" "developer_custom" {
  group      = aws_iam_group.all_groups["developers"].name
  policy_arn = var.developer_custom_policy_arn

  depends_on = [aws_iam_group.all_groups]
}


# -----------------------------------------------------------
# Attach DevOps Custom Policy to "devops" group
# -----------------------------------------------------------

resource "aws_iam_group_policy_attachment" "devops_custom" {
  group      = aws_iam_group.all_groups["devops"].name
  policy_arn = var.devops_custom_policy_arn

  depends_on = [aws_iam_group.all_groups]
}
