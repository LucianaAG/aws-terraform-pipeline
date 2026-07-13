variable "subnets" {
  type = map(object({
    cidr = string
    is_public = bool 
    availability_zone = string
  }))
}

variable "vpc_cidr" {
    description = "cidr block para la VPC"
    type = string
}

variable "tags" {
  description = "Tags para aplicar a los recursos"
  type        = map(string)
  default     = {}
}