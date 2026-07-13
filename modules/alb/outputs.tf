output "alb_dns_name" {
  description = "URL pública del load balancer"
  value = aws_alb.application_load_balancer.dns_name
}