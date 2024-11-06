resource "aws_instance" "nginx_instance"{
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = aws_subnet.main_subnet.id
    user_data     = file("./add-ssh-web-app.yaml") 
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.dev_group.id]
    tags = {
    Name = "APACHE_INSTANCE"
  }

  # Explicit dependency
    depends_on = [ # before the creation of the instance , the depends_on ensures that the required resources are created
    aws_subnet.main_subnet,
    aws_security_group.dev_group,
  ]

  
}