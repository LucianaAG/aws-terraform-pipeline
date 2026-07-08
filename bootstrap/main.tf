terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
      }
    }
}

provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "iam_dev" {
  source = "../modules/iam"

  env = "dev"
  tags = var.tags

}

module "iam_prod" {
  source = "../modules/iam"

  env = "prod"
  tags = var.tags
}