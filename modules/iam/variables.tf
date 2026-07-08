variable "env" {
  description = "entorno donde aplicar los recursos"
  type = string
}

variable "tags" {
  description = "Tags para aplicar a los recursos"
  type        = map(string)
  default     = {}
}