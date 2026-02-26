#!/bin/bash
# =============================================================
# scripts/setup.sh
# -------------------------------------------------------------
# PURPOSE: One-command setup script for freshers!
#          Run this to check your prerequisites and get started.
#
# HOW TO USE:
#   chmod +x scripts/setup.sh
#   ./scripts/setup.sh
# =============================================================

set -e  # Exit if any command fails

# Colors for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo ""
echo -e "${CYAN}============================================${NC}"
echo -e "${CYAN}  🔐 AWS IAM Project - Setup Script        ${NC}"
echo -e "${CYAN}  Perfect for Cloud Freshers!              ${NC}"
echo -e "${CYAN}============================================${NC}"
echo ""

# ----------------------------
# Check Prerequisites
# ----------------------------
echo -e "${BLUE}📋 Checking prerequisites...${NC}"
echo ""

check_command() {
  if command -v "$1" &>/dev/null; then
    VERSION=$($1 $2 2>&1 | head -1)
    echo -e "  ${GREEN}✅ $1 is installed${NC} — $VERSION"
  else
    echo -e "  ${RED}❌ $1 is NOT installed${NC}"
    echo -e "     Install guide: $3"
    MISSING=true
  fi
}

MISSING=false

check_command "terraform" "--version" "https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli"
check_command "aws" "--version" "https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"
check_command "git" "--version" "https://git-scm.com/downloads"

echo ""

if [ "$MISSING" = true ]; then
  echo -e "${RED}⚠️  Please install the missing tools above and run this script again.${NC}"
  exit 1
fi

# ----------------------------
# Check AWS Configuration
# ----------------------------
echo -e "${BLUE}🔑 Checking AWS credentials...${NC}"
echo ""

if aws sts get-caller-identity &>/dev/null; then
  ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
  USER_ARN=$(aws sts get-caller-identity --query Arn --output text)
  REGION=$(aws configure get region || echo "us-east-1")
  
  echo -e "  ${GREEN}✅ AWS credentials are configured!${NC}"
  echo -e "     Account ID : ${CYAN}$ACCOUNT_ID${NC}"
  echo -e "     Identity   : ${CYAN}$USER_ARN${NC}"
  echo -e "     Region     : ${CYAN}$REGION${NC}"
else
  echo -e "  ${RED}❌ AWS credentials not configured!${NC}"
  echo ""
  echo -e "  Run these commands to configure:"
  echo -e "  ${YELLOW}  aws configure${NC}"
  echo -e "  Then enter your:"
  echo -e "  • AWS Access Key ID"
  echo -e "  • AWS Secret Access Key"
  echo -e "  • Default Region (e.g., us-east-1)"
  echo -e "  • Output format (json)"
  exit 1
fi

echo ""

# ----------------------------
# Terraform Init
# ----------------------------
echo -e "${BLUE}🔧 Initializing Terraform...${NC}"
echo ""
terraform init

echo ""

# ----------------------------
# Terraform Validate
# ----------------------------
echo -e "${BLUE}✅ Validating Terraform configuration...${NC}"
echo ""
terraform validate

echo ""

# ----------------------------
# Summary
# ----------------------------
echo -e "${CYAN}============================================${NC}"
echo -e "${GREEN}  🎉 Setup Complete! You're ready to go!   ${NC}"
echo -e "${CYAN}============================================${NC}"
echo ""
echo -e "  ${BLUE}Next steps:${NC}"
echo -e ""
echo -e "  1️⃣   Preview what will be created:"
echo -e "       ${YELLOW}terraform plan${NC}"
echo ""
echo -e "  2️⃣   Create all resources:"
echo -e "       ${YELLOW}terraform apply${NC}"
echo ""
echo -e "  3️⃣   Get user passwords after apply:"
echo -e "       ${YELLOW}terraform output -json iam_user_passwords${NC}"
echo ""
echo -e "  4️⃣   Destroy everything when done learning:"
echo -e "       ${YELLOW}terraform destroy${NC}"
echo ""
echo -e "  📚 Read the README.md for full documentation!"
echo ""
