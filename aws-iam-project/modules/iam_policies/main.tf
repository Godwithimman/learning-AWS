# =============================================================
# modules/iam_policies/main.tf
# -------------------------------------------------------------
# PURPOSE: Creates custom IAM policies using JSON documents.
#
# 📖 LEARN: A Policy is a JSON document that says:
#   - "Effect": Allow or Deny
#   - "Action": What API calls are allowed (e.g., s3:GetObject)
#   - "Resource": Which resources (e.g., a specific S3 bucket)
#
# AWS Managed Policies are pre-built by Amazon.
# Custom Policies are written by YOU for specific needs.
# =============================================================

# -----------------------------------------------------------
# POLICY 1: MFA Enforcement Policy
# -----------------------------------------------------------
# Forces users to set up MFA before they can do anything.
# Without MFA, they can ONLY manage their own MFA device.
#
# 📖 LEARN: MFA = Multi-Factor Authentication
#           It's like a second password — usually a phone app.
#           This policy blocks all actions if MFA is not active.
# -----------------------------------------------------------

resource "aws_iam_policy" "enforce_mfa" {
  name        = "${var.project_name}-enforce-mfa"
  description = "Forces users to enable MFA before accessing AWS resources"

  # jsonencode() converts a Terraform map to a JSON string
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        # ALLOW users to view the IAM console (to set up MFA)
        Sid    = "AllowViewAccountInfo"
        Effect = "Allow"
        Action = [
          "iam:GetAccountPasswordPolicy",
          "iam:ListVirtualMFADevices"
        ]
        Resource = "*"
      },
      {
        # ALLOW users to manage THEIR OWN MFA device
        Sid    = "AllowManageOwnMFA"
        Effect = "Allow"
        Action = [
          "iam:CreateVirtualMFADevice",
          "iam:EnableMFADevice",
          "iam:GetUser",
          "iam:ListMFADevices",
          "iam:ResyncMFADevice"
        ]
        Resource = [
          "arn:aws:iam::*:mfa/&{aws:username}",
          "arn:aws:iam::*:user/&{aws:username}"
        ]
      },
      {
        # ALLOW users to manage their own password
        Sid    = "AllowManageOwnPasswords"
        Effect = "Allow"
        Action = [
          "iam:ChangePassword",
          "iam:GetUser"
        ]
        Resource = "arn:aws:iam::*:user/&{aws:username}"
      },
      {
        # DENY everything else if MFA is NOT present
        Sid    = "DenyAllExceptListedIfNoMFA"
        Effect = "Deny"
        NotAction = [
          "iam:CreateVirtualMFADevice",
          "iam:EnableMFADevice",
          "iam:GetUser",
          "iam:ListMFADevices",
          "iam:ListVirtualMFADevices",
          "iam:ResyncMFADevice",
          "sts:GetSessionToken"
        ]
        Resource = "*"

        # Condition: Only deny IF MFA is not authenticated
        Condition = {
          BoolIfExists = {
            "aws:MultiFactorAuthPresent" = "false"
          }
        }
      }
    ]
  })

  tags = {
    Name    = "MFA Enforcement Policy"
    Purpose = "Security"
  }
}


# -----------------------------------------------------------
# POLICY 2: Developer Custom Policy
# -----------------------------------------------------------
# Grants developers fine-grained access to specific services
# while blocking dangerous operations.
# -----------------------------------------------------------

resource "aws_iam_policy" "developer_custom" {
  name        = "${var.project_name}-developer-custom"
  description = "Custom policy for developers: EC2, S3, Lambda, CloudWatch, DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        # ALLOW: EC2 read and basic operations (no termination of others' instances)
        Sid    = "AllowEC2ReadAndBasicOps"
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:RebootInstances"
        ]
        Resource = "*"
      },
      {
        # ALLOW: S3 full access to buckets with project prefix only
        Sid    = "AllowS3ProjectBuckets"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ]
        Resource = [
          "arn:aws:s3:::${var.project_name}-*",
          "arn:aws:s3:::${var.project_name}-*/*"
        ]
      },
      {
        # ALLOW: Lambda — create, update, invoke functions
        Sid    = "AllowLambdaOps"
        Effect = "Allow"
        Action = [
          "lambda:CreateFunction",
          "lambda:UpdateFunctionCode",
          "lambda:UpdateFunctionConfiguration",
          "lambda:InvokeFunction",
          "lambda:GetFunction",
          "lambda:ListFunctions",
          "lambda:DeleteFunction",
          "lambda:AddPermission",
          "lambda:RemovePermission"
        ]
        Resource = "*"
      },
      {
        # ALLOW: CloudWatch — view logs and create dashboards
        Sid    = "AllowCloudWatchLogs"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:GetLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics",
          "cloudwatch:PutDashboard",
          "cloudwatch:GetDashboard"
        ]
        Resource = "*"
      },
      {
        # ALLOW: DynamoDB — full CRUD on project tables
        Sid    = "AllowDynamoDBProjectTables"
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:DescribeTable",
          "dynamodb:CreateTable",
          "dynamodb:DeleteTable"
        ]
        Resource = "arn:aws:dynamodb:*:*:table/${var.project_name}-*"
      },
      {
        # DENY: Never allow IAM write operations for developers
        Sid    = "DenyIAMWrite"
        Effect = "Deny"
        Action = [
          "iam:CreateUser",
          "iam:DeleteUser",
          "iam:AttachUserPolicy",
          "iam:DetachUserPolicy",
          "iam:CreateAccessKey"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name    = "Developer Custom Policy"
    Purpose = "DeveloperAccess"
  }
}


# -----------------------------------------------------------
# POLICY 3: DevOps Custom Policy
# -----------------------------------------------------------
# Extra permissions for DevOps engineers on top of PowerUserAccess
# -----------------------------------------------------------

resource "aws_iam_policy" "devops_custom" {
  name        = "${var.project_name}-devops-custom"
  description = "Extra DevOps permissions: ECS, ECR, CloudFormation, Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        # ALLOW: ECS — manage containers and tasks
        Sid    = "AllowECS"
        Effect = "Allow"
        Action = [
          "ecs:*",
          "ecr:*"
        ]
        Resource = "*"
      },
      {
        # ALLOW: CloudFormation — infrastructure stacks
        Sid    = "AllowCloudFormation"
        Effect = "Allow"
        Action = [
          "cloudformation:*"
        ]
        Resource = "*"
      },
      {
        # ALLOW: Secrets Manager — manage app secrets
        Sid    = "AllowSecretsManager"
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:CreateSecret",
          "secretsmanager:UpdateSecret",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecrets"
        ]
        Resource = "*"
      },
      {
        # ALLOW: SSM Parameter Store — for config management
        Sid    = "AllowSSMParameterStore"
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:PutParameter",
          "ssm:DeleteParameter",
          "ssm:DescribeParameters"
        ]
        Resource = "*"
      },
      {
        # ALLOW: Route53 — DNS management
        Sid    = "AllowRoute53"
        Effect = "Allow"
        Action = [
          "route53:*",
          "route53domains:*"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name    = "DevOps Custom Policy"
    Purpose = "DevOpsAccess"
  }
}


# -----------------------------------------------------------
# POLICY 4: Read-Only S3 Policy (example of a narrow policy)
# -----------------------------------------------------------
# A very specific policy allowing read access to ONE bucket.
# Shows how to write least-privilege policies.
# -----------------------------------------------------------

resource "aws_iam_policy" "s3_readonly_project" {
  name        = "${var.project_name}-s3-readonly"
  description = "Read-only access to project S3 buckets — example of least-privilege"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowS3ListAndRead"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ]
        Resource = [
          "arn:aws:s3:::${var.project_name}-*",
          "arn:aws:s3:::${var.project_name}-*/*"
        ]
      }
    ]
  })

  tags = {
    Name    = "S3 Read-Only Project Policy"
    Purpose = "LeastPrivilege"
  }
}
