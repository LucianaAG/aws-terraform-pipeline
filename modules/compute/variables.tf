variable "subnet_id" {
    description = "id de la subnet para la instancia"
    type = string
}

variable "instance_type" {
    description = "configuración de la instancia"
    type = string
}

variable "security_group_id" {
  description = "reglas de seguridad para la instancia"
  type = string
}


variable "tags" {
  description = "Tags para aplicar a los recursos"
  type        = map(string)
  default     = {}
}

variable "env" {
  description = "nombre del entorno"
  type = string
}