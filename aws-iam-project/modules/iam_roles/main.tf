# =============================================================
# modules/iam_roles/main.tf
# -------------------------------------------------------------
# PURPOSE: Creates IAM Roles for AWS services (EC2, Lambda, ECS)
#          and for special use cases (CI/CD, cross-account).
#
# 📖 LEARN: Roles are like "job titles" for AWS services.
#           When an EC2 instance needs to read from S3,
#           it assumes a Role — NOT a username/password.
#
#           A role has TWO parts:
#           1. "Trust Policy"  → WHO can assume this role?
#              (e.g., "EC2 service is allowed to use this role")
#           2. "Permission Policy" → WHAT can they do?
#              (e.g., "Can read from S3, write to CloudWatch")
# =============================================================


# -----------------------------------------------------------
# ROLE 1: EC2 Instance Role
# -----------------------------------------------------------
# Used by EC2 instances to access S3, SSM, CloudWatch.
# You attach this role as an "Instance Profile" when launching EC2.
#
# 📖 USE CASE: Your web server needs to read config from S3.
#              Instead of storing AWS keys on the server (DANGEROUS!),
#              you give the server a role. Much safer!
# -----------------------------------------------------------

resource "aws_iam_role" "ec2_instance_role" {
  name        = "${var.project_name}-ec2-instance-role"
  description = "Role for EC2 instances to access S3, SSM, and CloudWatch"

  # Trust Policy: "Who is allowed to ASSUME (use) this role?"
  # Here we allow the EC2 SERVICE to assume this role.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"  # The EC2 service
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "EC2 Instance Role"
    Description = "Attach to EC2 instances via instance profile"
  }
}

# Attach AWS managed policies to the EC2 role
resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  role       = aws_iam_role.ec2_instance_role.name
  # SSM = AWS Systems Manager — allows remote access without SSH keys!
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ec2_cloudwatch" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "ec2_s3_readonly" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Instance Profile — wraps the role so EC2 can use it
# 📖 LEARN: EC2 specifically needs an "Instance Profile" wrapper around roles
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-ec2-instance-profile"
  role = aws_iam_role.ec2_instance_role.name
}


# -----------------------------------------------------------
# ROLE 2: Lambda Execution Role
# -----------------------------------------------------------
# Used by Lambda functions to write logs, access DynamoDB, SQS.
#
# 📖 USE CASE: A Lambda function that processes orders needs
#              to write to DynamoDB and send SQS messages.
# -----------------------------------------------------------

resource "aws_iam_role" "lambda_execution_role" {
  name        = "${var.project_name}-lambda-execution-role"
  description = "Role for Lambda functions — CloudWatch Logs, DynamoDB, SQS access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "Lambda Execution Role"
  }
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_execution_role.name
  # Gives Lambda permission to write CloudWatch logs
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Custom inline policy for Lambda — fine-grained DynamoDB + SQS access
resource "aws_iam_role_policy" "lambda_custom" {
  name = "${var.project_name}-lambda-dynamodb-sqs"
  role = aws_iam_role.lambda_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = "arn:aws:dynamodb:${var.aws_region}:*:table/${var.project_name}-*"
      },
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = "arn:aws:sqs:${var.aws_region}:*:${var.project_name}-*"
      }
    ]
  })
}


# -----------------------------------------------------------
# ROLE 3: CI/CD Deployment Role (GitHub Actions via OIDC)
# -----------------------------------------------------------
# Used by GitHub Actions to deploy to AWS WITHOUT storing
# long-lived AWS credentials as GitHub secrets.
#
# 📖 LEARN: OIDC = OpenID Connect. GitHub Actions can "prove"
#           its identity to AWS using a token, and AWS gives
#           it temporary credentials. No passwords stored!
#           This is the MODERN and SECURE way to do CI/CD!
# -----------------------------------------------------------

resource "aws_iam_role" "cicd_deployment_role" {
  name        = "${var.project_name}-cicd-deployment-role"
  description = "Role for GitHub Actions CI/CD deployments via OIDC (no long-lived keys)"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          # GitHub's OIDC provider (you need to create this in AWS first)
          Federated = "arn:aws:iam::*:oidc-provider/token.actions.githubusercontent.com"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            # IMPORTANT: Change "YOUR_USERNAME/YOUR_REPO" to your actual GitHub repo!
            "token.actions.githubusercontent.com:sub" = "repo:YOUR_USERNAME/YOUR_REPO:*"
          }
        }
      }
    ]
  })

  tags = {
    Name        = "GitHub Actions CI/CD Role"
    Description = "Allows GitHub Actions to deploy without storing AWS credentials"
  }
}

resource "aws_iam_role_policy_attachment" "cicd_ecr" {
  role       = aws_iam_role.cicd_deployment_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "cicd_ecs" {
  role       = aws_iam_role.cicd_deployment_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_role_policy_attachment" "cicd_lambda" {
  role       = aws_iam_role.cicd_deployment_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}


# -----------------------------------------------------------
# ROLE 4: Cross-Account Read-Only Role
# -----------------------------------------------------------
# Allows another AWS account to read resources in this account.
#
# 📖 USE CASE: Your security team has a SEPARATE AWS account
#              and wants to audit this production account.
#              You give them a read-only role to assume.
# -----------------------------------------------------------

resource "aws_iam_role" "cross_account_readonly" {
  name        = "${var.project_name}-cross-account-readonly"
  description = "Allows another AWS account to have read-only access to this account"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          # CHANGE THIS: Replace with the account ID that needs access
          AWS = "arn:aws:iam::123456789012:root"
        }
        Action = "sts:AssumeRole"
        Condition = {
          # Require MFA even for role assumption
          Bool = {
            "aws:MultiFactorAuthPresent" = "true"
          }
        }
      }
    ]
  })

  tags = {
    Name = "Cross-Account Read-Only Role"
  }
}

resource "aws_iam_role_policy_attachment" "cross_account_readonly" {
  role       = aws_iam_role.cross_account_readonly.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}


# -----------------------------------------------------------
# ROLE 5: RDS Monitoring Role
# -----------------------------------------------------------
# Used by RDS Enhanced Monitoring to publish metrics to CloudWatch.
# -----------------------------------------------------------

resource "aws_iam_role" "rds_monitoring_role" {
  name        = "${var.project_name}-rds-monitoring-role"
  description = "Allows RDS to publish enhanced monitoring metrics to CloudWatch"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "RDS Enhanced Monitoring Role"
  }
}

resource "aws_iam_role_policy_attachment" "rds_monitoring" {
  role       = aws_iam_role.rds_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}


# -----------------------------------------------------------
# ROLE 6: ECS Task Role
# -----------------------------------------------------------
# Used by ECS containers (tasks) to call other AWS services.
# This is separate from the Task Execution Role (which pulls images).
#
# 📖 LEARN:
#   - Task Execution Role = ECS agent pulls Docker images from ECR
#   - Task Role          = YOUR application code inside the container
#                          calls DynamoDB, S3, SQS, etc.
# -----------------------------------------------------------

resource "aws_iam_role" "ecs_task_role" {
  name        = "${var.project_name}-ecs-task-role"
  description = "Role for ECS tasks — containers use this to access AWS services"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "ECS Task Application Role"
  }
}

resource "aws_iam_role_policy" "ecs_task_custom" {
  name = "${var.project_name}-ecs-task-permissions"
  role = aws_iam_role.ecs_task_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.project_name}-*",
          "arn:aws:s3:::${var.project_name}-*/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = "arn:aws:secretsmanager:${var.aws_region}:*:secret:${var.project_name}/*"
      },
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters"
        ]
        Resource = "arn:aws:ssm:${var.aws_region}:*:parameter/${var.project_name}/*"
      }
    ]
  })
}
