vpc_cidr = "172.16.0.0/20"

instance_type = "t3.medium"

subnets = {
  "prod_public_subnet" = {
    cidr = "172.16.2.0/24"
    is_public = true
  }

  "prod_private_subnet" = {
    cidr = "172.16.2.0/24"
    is_public = false
  }
}

tags = {
  "environment" = "prod"
  "managed-by"  = "terraform"
  "project"     = "aws-terraform-pipeline"
}