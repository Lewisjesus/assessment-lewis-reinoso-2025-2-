######################################################################
# Provider AWS
######################################################################
provider "aws" {
  region  = var.aws_region
  #profile = "default"
  # assume_role {
  #   role_arn    = "#{aws.iam.role.deploy}#"
  # }

  default_tags {
    tags = var.resource_tags
  }
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=4.31.0"
    }
  }
  required_version = ">=1.5.2"
   backend "s3" {
      region         = "us-east-1"
      bucket         = "reto-banco-dev"
      key            = "statetf/terraform.tfstate"
   }
}