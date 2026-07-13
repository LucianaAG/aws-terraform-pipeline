output "instance_public_ip" {
  description = "IP pública de la instancia EC2"
  value       = values(module.compute.instance_public_ips)[0]
}