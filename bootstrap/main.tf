terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

data "tls_certificate" "hcp" {
  url = "https://app.terraform.io/.well-known/openid-configuration"
}

# OIDC provider le dice a AWS que confíe en HCP para levantar la infra

resource "aws_iam_openid_connect_provider" "hcp" {
  url = "https://app.terraform.io"

  client_id_list = ["aws.workload.identity"]

  thumbprint_list = [data.tls_certificate.hcp.certificates[0].sha1_fingerprint]
}

# OIDC entre Github Actions y AWS, le pide a AWS que confie en GitHub actions para que pushee las nuevas imagenes buildeadas
# al repositorio de imagenes ECR
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

# rol que HCP va a asumir
resource "aws_iam_role" "hcp_role" {
  name = "hcp-terraform-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.hcp.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "app.terraform.io:aud" = "aws.workload.identity"
          }
          "StringLike" = {
            "app.terraform.io:sub" = "organization:aws-infrastructure-portfolio:project:Default Project:workspace:*:run_phase:*"
          }
        }
      }
    ]
  })
}

# rol que GitHub Actions va a asumir
resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:LucianaAG/agente-ia-corporativo:*"
          }
        }
      }
    ]
  })
}

# definicion de los permisos del rol, acceso completo para poder desplegar infra
resource "aws_iam_role_policy_attachment" "hcp_policy" {
  role       = aws_iam_role.hcp_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# definicion de los permisos del rol para github actions, le permite registrar nuevas imagenes
resource "aws_iam_role_policy_attachment" "github_ecr_policy" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

# definicion de los permisos del rol para github actions, le permite registrar nuevas imagenes
resource "aws_iam_role_policy_attachment" "github_ssm_policy" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "iam_dev" {
  source = "../modules/iam"

  env  = "dev"
  tags = var.tags

}

module "iam_prod" {
  source = "../modules/iam"

  env  = "prod"
  tags = var.tags
}