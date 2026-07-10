output "instance_public_ip" {
  description = "IP pública de la instancia EC2"
  value       = module.compute.instance_public_ip
}