# =============================================================
# environments/prod/main.tf
# -------------------------------------------------------------
# PURPOSE: Production environment — strict security settings.
#          Shorter password expiry, longer reuse prevention.
#
# ⚠️  WARNING: Changes to PROD affect real users and services.
#              Always run `terraform plan` and review carefully!
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

  # ⚠️ For PROD, always use remote state!
  # backend "s3" {
  #   bucket         = "your-company-terraform-state"
  #   key            = "prod/iam/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-locks"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Environment = "prod"
      ManagedBy   = "Terraform"
      Project     = "aws-iam-learning"
      CriticalEnv = "true"
    }
  }
}

module "iam" {
  source = "../../"

  aws_region   = "us-east-1"
  environment  = "prod"
  project_name = "iam-learning-prod"
  owner        = "platform-team"

  # Strict password policy for production
  password_min_length       = 16   # Longer passwords in prod
  password_max_age          = 60   # Change every 60 days
  password_reuse_prevention = 10   # Can't reuse last 10 passwords
}
