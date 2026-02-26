# =============================================================
# outputs.tf
# -------------------------------------------------------------
# PURPOSE: Display useful information after `terraform apply`
#
# 📖 LEARN: Outputs are like "return values" from Terraform.
#           They show you the IDs, ARNs, and other info about
#           the resources that were just created.
#           You can also use outputs between modules!
# =============================================================

# ----------------------------
# User Outputs
# ----------------------------

output "iam_user_names" {
  description = "List of all IAM user names created"
  value       = module.iam_users.user_names
}

output "iam_user_arns" {
  description = "Map of username => ARN for all created users"
  value       = module.iam_users.user_arns
}

# ⚠️ SENSITIVE: Passwords are marked sensitive so they don't
# accidentally show up in logs or CI/CD output
output "iam_user_passwords" {
  description = "Temporary passwords for all users (change on first login!)"
  value       = module.iam_users.user_passwords
  sensitive   = true  # Hidden from terminal output — use: terraform output -json iam_user_passwords
}

# ----------------------------
# Group Outputs
# ----------------------------

output "iam_group_names" {
  description = "List of all IAM group names created"
  value       = module.iam_groups.group_names
}

output "iam_group_arns" {
  description = "Map of group name => ARN for all created groups"
  value       = module.iam_groups.group_arns
}

# ----------------------------
# Role Outputs
# ----------------------------

output "iam_role_names" {
  description = "List of all IAM role names created"
  value       = module.iam_roles.role_names
}

output "iam_role_arns" {
  description = "Map of role name => ARN (use these to attach roles to EC2, Lambda, etc.)"
  value       = module.iam_roles.role_arns
}

output "ec2_instance_profile_name" {
  description = "EC2 Instance Profile name — use this when launching EC2 instances"
  value       = module.iam_roles.ec2_instance_profile_name
}

output "lambda_execution_role_arn" {
  description = "Lambda Execution Role ARN — use this when creating Lambda functions"
  value       = module.iam_roles.lambda_execution_role_arn
}

output "cicd_deployment_role_arn" {
  description = "CI/CD Role ARN — use in GitHub Actions for deployments"
  value       = module.iam_roles.cicd_deployment_role_arn
}

# ----------------------------
# Policy Outputs
# ----------------------------

output "custom_policy_arns" {
  description = "ARNs of all custom policies created"
  value       = module.iam_policies.all_policy_arns
}

# ----------------------------
# Summary Output
# ----------------------------

output "summary" {
  description = "A human-readable summary of what was created"
  value = <<-EOT
    ==========================================
    ✅ AWS IAM Project Deployed Successfully!
    ==========================================
    🌍 Region     : ${var.aws_region}
    🏗️  Environment : ${var.environment}
    👥 Users       : ${length(var.iam_users)} created
    🏢 Groups      : ${length(var.iam_groups)} created
    🔐 Roles       : 6 created
    📋 Policies    : 4 custom policies created

    ⚠️  NEXT STEPS:
    1. Run: terraform output -json iam_user_passwords
    2. Share each user their temporary password
    3. Instruct users to change password on first login
    4. Enable MFA for all human users!
    ==========================================
  EOT
}
