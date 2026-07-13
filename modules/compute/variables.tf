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

variable "instances" {
  description = "Mapa de instancias con sus subnets asignadas"
  type = map(object({
    subnet_key = string 
  }))
}

variable "subnet_ids" {
  description = "Mapa de IDs de subnets"
  type        = map(string)
}