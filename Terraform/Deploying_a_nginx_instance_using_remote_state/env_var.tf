variable "aws_region" {
  description = "The AWS region of EC2 where the instance will be install"
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "The specific AWS Availability Zone within the EC2 region where the instance will be installed"
  default     = "us-east-1a"  
}


variable "instance_type" {
  description = "The instace type that will be install"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "ID of an image of the intance, in this case is a id of an image of an instance in us-east-1 zone"
  default     = "ami-0ebfd941bbafe70c6" 
}

variable "cidr_block_vpc" {
  description = "cidr_block of the VPC" #CIDR IS A RANGE OF IPS THAT ARE AVAILABLE FOR THE VPC
  default     = "10.0.0.0/16"
}

variable "cidr_block_subnet" {
  description = "cidr_block of the subnet"
  default     = "10.0.1.0/24"
}

variable "security_group" {
  description = "security_group" # a type of virtual firewall
  default     = "dev_group"
}

#variable "bucket_name" {
#  description = "bucket_name" #the name of the bucket
#  default     = "terraform-workshop"
#}

#variable "dynamodb_table_name" {
#  description = "dynamo_table_name" #the name of the bucket
#  default     = "lock-id-table"
#}


