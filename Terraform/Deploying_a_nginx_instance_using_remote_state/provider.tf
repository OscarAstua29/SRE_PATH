terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" #It defines the source and the version that will be use
      version = "~> 5.0"
    }
  }

  backend "s3"{
    bucket         = "terraform-workshop-nginx"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_locks"
    encrypt        =  true
  }

  required_version = ">= 1.2.0" # The minimun version of terraform allow required to deploy this hcl
}


provider "aws" {
  region                   = var.aws_region  # The aws region to deploy the resources
}

