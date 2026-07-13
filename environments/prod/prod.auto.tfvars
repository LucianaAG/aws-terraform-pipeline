vpc_cidr = "172.16.0.0/20"

instance_type = "t2.micro"

subnets = {
  "prod_public_subnet_az1" = {
    cidr = "172.16.2.0/24"
    is_public = true
    availability_zone = "us-east-1a"
  }

  "prod_second_public_subnet_az2" = {
    cidr = "172.16.3.0/24"
    is_public = true
    availability_zone = "us-east-1b"
  }

  "prod_private_subnet" = {
    cidr = "172.16.4.0/24"
    is_public = false
    availability_zone = "us-east-1a"
  }

  "prod_second_private_subnet" = {
    cidr = "172.16.5.0/24"
    is_public = false
    availability_zone = "us-east-1b"
  }
}

instances = {
  instance_1 = { subnet_key = "prod_public_subnet_az1" }
  instance_2 = { subnet_key = "prod_public_subnet_az1" }
  instance_3 = { subnet_key = "prod_second_public_subnet_az2" }
  instance_4 = { subnet_key = "prod_second_public_subnet_az2" }
}

tags = {
  "environment" = "prod"
  "managed-by"  = "terraform"
  "project"     = "aws-terraform-pipeline"
}