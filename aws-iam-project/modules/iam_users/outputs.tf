# modules/iam_users/outputs.tf

output "user_names" {
  description = "List of all IAM usernames created"
  value       = [for user in aws_iam_user.users : user.name]
}

output "user_arns" {
  description = "Map of username => ARN"
  value       = { for k, user in aws_iam_user.users : k => user.arn }
}

output "user_passwords" {
  description = "Map of username => temporary password (SENSITIVE)"
  value       = { for k, profile in aws_iam_user_login_profile.profiles : k => profile.password }
  sensitive   = true
}
