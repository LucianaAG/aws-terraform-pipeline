output "instance_public_ips" {
  description = "IPs públicas de las instancias EC2"
  value       = { for key, instance in aws_instance.server : key => instance.public_ip }
}

output "instance_profile_name" {
  description = "Nombre del instance profile para SSM"
  value       = aws_iam_instance_profile.ssm_profile.name
}

output "instance_ids" {
  description = "IDs de las instancias EC2"
  value       = { for key, instance in aws_instance.server : key => instance.id }
}