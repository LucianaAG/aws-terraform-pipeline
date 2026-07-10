terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

terraform {
  cloud {
    organization = "aws-infra-portfolio"

    workspaces {
      name = "dev"
    }
  }
}