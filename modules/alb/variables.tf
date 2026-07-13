variable "vpc_id" {
    description = "para crear el security group del balanceador"
    type = string
}

# de tipo list, porque recibe multiples subnets
variable "subnet_ids" {
  description = "ids de las subnets donde opera"
  type        = list(string)
}

# de tipo list tambien porque recibe multiples instancias
variable "instance_ids" {
  description = "ids de las instancias entre las cuales reparte el trafico"
  type        = list(string)
}

variable "tags" {
  description = "Tags para aplicar a los recursos"
  type        = map(string)
  default     = {}
}