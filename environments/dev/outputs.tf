output "instance_public_ip" {
  description = "IP pública de la instancia EC2"
  value       = values(module.compute.instance_public_ips)[0]
}

output "ecr_repository_url" {
  description = "URL del repositorio ECR"
  value       = module.ecr.repository_url
}