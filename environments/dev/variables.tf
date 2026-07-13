variable "region" {
  description = "region"
  type = string
}

variable "subnets" {
  type = map(object({
    cidr      = string
    is_public = bool
  }))
}

variable "vpc_cidr" {
  description = "bloque cidr para la instancia"
  type = string
}

variable "tags" {
  description = "Tag para los recursos"
  type        = map(string)
  default     = {}
}

variable "instance_type" {
  description = "configuracion de la instancia"
  type = string
}

variable "instances" {
  description = "Mapa de instancias con su subnet asignada"
  type = map(object({
    subnet_key = string
  }))
}