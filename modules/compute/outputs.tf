output "instance_public_ip" {
  description = "IP publica de la instancia EC2"
  value = aws_instance.server.public_ip
}

output "instance_profile_name" {
  description = "Nombre del instance profile para SSM"
  value       = aws_iam_instance_profile.ssm_profile.name
}