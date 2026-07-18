resource "aws_ecr_repository" "app" {
  name                 = "${lookup(var.tags, "environment", "dev")}-agente-ia"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}