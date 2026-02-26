# modules/iam_groups/outputs.tf

output "group_names" {
  description = "Map of group key => group name (used by users module)"
  value       = { for k, g in aws_iam_group.all_groups : k => g.name }
}

output "group_arns" {
  description = "Map of group name => ARN"
  value       = { for k, g in aws_iam_group.all_groups : k => g.arn }
}
