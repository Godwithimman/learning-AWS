# =============================================================
# terraform.tfvars
# -------------------------------------------------------------
# PURPOSE: Override default variable values here.
#          This file is your main configuration file.
#
# ⚠️  SECURITY WARNING:
#     If this file contains sensitive values (passwords, keys),
#     add it to .gitignore and NEVER commit it to GitHub!
#     This file is safe because it only has non-sensitive config.
#
# 📖 LEARN: terraform.tfvars is automatically loaded by Terraform.
#           You can also use: terraform apply -var-file="prod.tfvars"
# =============================================================

# AWS region to deploy into
aws_region = "us-east-1"

# Environment label — shown in all resource tags
environment = "dev"

# Your name or team name (for tagging)
owner = "your-name-here"

# Project name prefix used in resource names
project_name = "iam-learning-project"

# Password policy settings
password_min_length       = 12
password_max_age          = 90
password_reuse_prevention = 5
