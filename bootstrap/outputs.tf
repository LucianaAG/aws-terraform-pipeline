output "hcp_role_arn" {
  description = "ARN del rol que HCP asume via OIDC"
  value       = aws_iam_role.hcp_role.arn
}