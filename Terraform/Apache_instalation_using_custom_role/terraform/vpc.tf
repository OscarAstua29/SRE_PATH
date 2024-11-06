# Create a Security group in the VPC
resource "aws_security_group" "dev_group" {
  vpc_id = aws_vpc.main_vpc.id

  description = "dev securuty grup"

  ingress {
    from_port   = 22                # allow SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]     # allow any IP
  }

  ingress {
    from_port   = 80                 # allow HTTP
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]     # allow any IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"              # Permit the egress traffic from all IP addresses
    cidr_blocks = ["0.0.0.0/0"]     # Allow access from any IP address.
  }

  tags = {
    Name = "dev_group"
  }
}

# Create a vpc
resource "aws_vpc" "main_vpc" {
  cidr_block = var.cidr_block_vpc
  tags = {
    Name = "MainVPC"
  }
}

# Create a Subnet in the VPC
resource "aws_subnet" "main_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.cidr_block_subnet
  availability_zone = var.availability_zone 
  tags = {
    Name = "MainSubnet"
  }
}

resource "aws_internet_gateway" "main_igw" { # the gateway its just a door bewteen our VPC and internet
  vpc_id = aws_vpc.main_vpc.id 
  tags = {
    Name = "VPC_IGW"
  }
}

# Create Route Table
resource "aws_route_table" "main_route_table" { # the route table defines the path if packets within a network
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "VPC_RT"
  }
}

# Create a Route to the Internet
resource "aws_route" "public_access" { # it creates a route in the VPC_RT between the vpc to the gateway
  route_table_id         = aws_route_table.main_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_igw.id
}

resource "aws_route_table_association" "public_rt" {# it allows the traffic from the subnet to the route table
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.main_route_table.id
}