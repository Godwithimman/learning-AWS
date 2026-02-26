# modules/iam_roles/outputs.tf

output "role_names" {
  description = "List of all role names"
  value = [
    aws_iam_role.ec2_instance_role.name,
    aws_iam_role.lambda_execution_role.name,
    aws_iam_role.cicd_deployment_role.name,
    aws_iam_role.cross_account_readonly.name,
    aws_iam_role.rds_monitoring_role.name,
    aws_iam_role.ecs_task_role.name,
  ]
}

output "role_arns" {
  description = "Map of role name => ARN"
  value = {
    ec2_instance_role      = aws_iam_role.ec2_instance_role.arn
    lambda_execution_role  = aws_iam_role.lambda_execution_role.arn
    cicd_deployment_role   = aws_iam_role.cicd_deployment_role.arn
    cross_account_readonly = aws_iam_role.cross_account_readonly.arn
    rds_monitoring_role    = aws_iam_role.rds_monitoring_role.arn
    ecs_task_role          = aws_iam_role.ecs_task_role.arn
  }
}

output "ec2_instance_profile_name" {
  description = "EC2 Instance Profile name — use this when launching EC2 instances"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "lambda_execution_role_arn" {
  description = "Lambda Role ARN — use this in aws_lambda_function resources"
  value       = aws_iam_role.lambda_execution_role.arn
}

output "cicd_deployment_role_arn" {
  description = "CI/CD Role ARN — configure this in GitHub Actions"
  value       = aws_iam_role.cicd_deployment_role.arn
}
