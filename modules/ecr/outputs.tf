# para que el pipeline CI/CD pueda pushear la imagen, necesita la URL del repositorio de imagenes en AWS
output "repository_url" {
  description = "URL del repositorio ECR"
  value       = aws_ecr_repository.app.repository_url
}

# RECORDAR: Los archivos outputs.tf de los modulos, exponen para los entornos y los entornos para afuera, la consola
# por eso es necesario volver a exponer el output en el entorno