# levantamos el servicio donde se almacenará cada nueva imagen buildeada por el pipeline
# la instancia EC2 extrae las imagenes de este servicio
resource "aws_ecr_repository" "app" {
  name                 = "${lookup(var.tags, "environment", "dev")}-agente-ia"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}