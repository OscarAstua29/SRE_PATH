terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" #It defines the source and the version that will be use
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0" # The minimun version of terraformallow required to deploy this hcl
}


provider "aws" {
  region = var.aws_region  # The aws region to deploy the resources
}

resource "aws_instance" "nginx_instance"{
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = aws_subnet.main_subnet.id
    associate_public_ip_address = true
    user_data = file("nginx_installer.sh") #This line deploy the scipt bash define in the file. 
    vpc_security_group_ids = [aws_security_group.dev_group.id]
    tags = {
    Name = "Nginx_instance_with_user_data"
  }

  # Explicit dependency
    depends_on = [ # before the creation of the instance , the depends_on ensures that the required resources are created
    aws_subnet.main_subnet,
    aws_security_group.dev_group
  ]

  
}