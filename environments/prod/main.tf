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


  env = "prod"
  subnet_ids         = module.network.subnet_ids
  security_group_id = module.network.security_group_id
  instance_type     = var.instance_type
  tags              = var.tags
  instances = var.instances
}

module "alb" {
  source = "../../modules/alb"

  vpc_id = module.network.vpc_id
  subnet_ids   = [for k, v in module.network.subnet_ids : v if contains(["prod_public_subnet_az1", "prod_second_public_subnet_az2"], k)]
  instance_ids = module.compute.instance_ids
  tags         = var.tags
}