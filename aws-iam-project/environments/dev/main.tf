# =============================================================
# environments/dev/main.tf
# -------------------------------------------------------------
# PURPOSE: Development environment — relaxed settings,
#          more users, easier access for learning.
#
# 📖 LEARN: Having separate environments (dev, prod) is
#           industry best practice. Dev is where you experiment.
#           Prod is the real deal — stricter rules apply!
#
# HOW TO USE THIS:
#   cd environments/dev
#   terraform init
#   terraform plan
#   terraform apply
# =============================================================

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Environment = "dev"
      ManagedBy   = "Terraform"
      Project     = "aws-iam-learning"
    }
  }
}

# Call the root module from the environments/dev directory
module "iam" {
  source = "../../"  # Points to the root of the project

  aws_region   = "us-east-1"
  environment  = "dev"
  project_name = "iam-learning-dev"
  owner        = "dev-team"

  # Relaxed password policy for development
  password_min_length       = 8
  password_max_age          = 365  # Longer expiry in dev
  password_reuse_prevention = 3
}

# ----------------------------
# Dev-Only Outputs
# ----------------------------

output "dev_summary" {
  value = "✅ DEV environment deployed — ${module.iam.summary}"
}
