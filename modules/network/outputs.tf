output "vpc_id" {
  description = "ID de la VPC"
  value       = aws_vpc.internal_vpc.id
}

output "vpc_cidr" {
  description = "CIDR block de la VPC"
  value       = aws_vpc.internal_vpc.cidr_block
}

output "subnet_ids" {
  description = "IDs de las subnets"
  value       = { for key, value in aws_subnet.this : key => value.id }
}

output "security_group_id" {
  description = "reglas de seguridad de la vpc"
  value       = aws_security_group.public_security_group.id

}