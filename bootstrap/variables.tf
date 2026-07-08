variable "region" {
  description = "region de la cuenta root"
  type = string
}

variable "access_key" {
  description = "clave de acceso"
  type = string
}

variable "secret_key" {
    description = "clave secreta de acceso"
    type = string
}

variable "tags" {
  description = "Tags para los recursos"
  type        = map(string)
  default     = {}
}