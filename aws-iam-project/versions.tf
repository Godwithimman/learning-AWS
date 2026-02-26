# =============================================================
# versions.tf
# -------------------------------------------------------------
# PURPOSE: Lock Terraform and Provider versions to ensure
#          consistent behavior across all team members.
#
# 📖 LEARN: Pinning versions prevents unexpected breaking
#           changes when new versions are released.
# =============================================================

terraform {
  # Minimum Terraform version required
  required_version = ">= 1.5.0"

  required_providers {
    # AWS Provider — this lets Terraform talk to AWS APIs
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Allow 5.x but not 6.x
    }

    # Random provider — used to generate random passwords
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }

  # -------------------------------------------------------
  # OPTIONAL: Remote State (uncomment to use S3 backend)
  # Store your terraform.tfstate file in S3 instead of locally.
  # This is required when working in a team!
  # -------------------------------------------------------
  # backend "s3" {
  #   bucket         = "my-terraform-state-bucket"
  #   key            = "iam/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-locks"   # For state locking
  #   encrypt        = true
  # }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region

  # Default tags applied to ALL resources created by Terraform
  # This is a best practice for cost tracking and resource management
  default_tags {
    tags = {
      Project     = "aws-iam-project"
      ManagedBy   = "Terraform"
      Environment = var.environment
      Owner       = var.owner
      Repository  = "https://github.com/YOUR_USERNAME/aws-iam-project"
    }
  }
}
