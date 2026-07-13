provider "aws" {
  region = var.region
}

module "network" {
  source = "../../modules/network"

  subnets = var.subnets
  vpc_cidr = var.vpc_cidr
  tags = var.tags
}

module "compute" {
  source = "../../modules/compute"

  env = "dev"
  subnet_ids         = module.network.subnet_ids
  security_group_id = module.network.security_group_id
  instance_type     = var.instance_type
  tags              = var.tags
  instances = var.instances
}