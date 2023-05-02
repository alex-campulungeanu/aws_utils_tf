terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.54.0"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_session_token
  # shared_credentials_files = ["~/.aws/credentials"]
  profile = "default"
  region     = var.aws_region
}

# module "s3" {
#   source = "./s3"
# }

module "lambda" {
  source = "./lambda"
}

# module "ec2" {
#   source = "./ec2"
# }