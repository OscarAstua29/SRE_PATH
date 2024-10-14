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
    aws_security_group.dev_group,
  ]

  
}

#resource "aws_dynamodb_table" "terraform_locks" {
#  name           = var.dynamodb_table_name
#  billing_mode   = "PROVISIONED" #Provisioned mode, it means you need to add w/r parameters

#  attribute {
#    name = "LockID"
#    type = "S"
#  }

#  hash_key = "LockID"

#    read_capacity  = 5
#    write_capacity = 5
  
#}

#resource "aws_s3_bucket" "terraform_state" {
#  bucket = var.bucket_name
  
#}

