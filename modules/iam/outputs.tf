output "group_id" {
    description = "group id"
    value = aws_iam_group.env_group.id
}

output "policy_arn" {
  description = "policy id"
  value = aws_iam_policy.env_policy.arn
}