vpc_cidr = "172.16.0.0/20"

instance_type = "t2.micro"

subnets = {
  "dev_public_subnet" = {
    cidr = "172.16.2.0/24"
    is_public = true
    availability_zone = "us-east-1a"
  }

  "dev_private_subnet" = {
    cidr = "172.16.3.0/24"
    is_public = false
    availability_zone = "us-east-1a"
  }
}

tags = {
  "environment" = "dev"
  "managed-by"  = "terraform"
  "project"     = "aws-terraform-pipeline"
}

instances = {
  dev_instance = { subnet_key = "dev_public_subnet" }
}