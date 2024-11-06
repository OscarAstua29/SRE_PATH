output "instance_id" { # output of the instance id
  value = aws_instance.nginx_instance.id
}

output "instance_public_ip" {# output of the public ip
  description = "EC2 PUBLIC IP"
  value       = aws_instance.nginx_instance.public_ip
}