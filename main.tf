terraform {
  backend "s3" {
    bucket         = "tf-state-file-backend-bucket"
    key            = "tf-infra/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

module "tf-state" {
  source      = "./modules/tf-state"
  bucket_name = "tf-state-file-backend"
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = local.availability_zones
  availability_zones   = local.vpc_cidr
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
}

