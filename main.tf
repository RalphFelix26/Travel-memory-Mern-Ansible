provider "aws" {
  region = "us-east-1"
}

# Reference existing VPC
data "aws_vpc" "existing_vpc" {
  id = "vpc-01bef558564914f1d"
}

# Reference existing Public Subnet
data "aws_subnet" "public_subnet" {
  id = "subnet-0077505222208742a"
}

# Reference existing Private Subnet
data "aws_subnet" "private_subnet" {
  id = "subnet-0274b06ea28288e42"
}

resource "aws_instance" "web_server" {
  ami             = "ami-084568db4383264d4"  # Ubuntu AMI
  instance_type   = "t2.micro"
  subnet_id       = data.aws_subnet.public_subnet.id
  security_groups = ["sg-0dc6320fa5472525a"]  # Use your NikhilSG security group ID
  key_name        = "Ralph-B8"  # Replace with your key name
  tags = {
    Name = "RalphWebServer"
  }
}

resource "aws_instance" "db_server" {
  ami             = "ami-084568db4383264d4"
  instance_type   = "t2.micro"
  subnet_id       = data.aws_subnet.private_subnet.id
  security_groups = ["sg-0dc6320fa5472525a"]  # Use the same security group
  tags = {
    Name = "RalphDBServer"
  }
}

output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "db_server_private_ip" {
  value = aws_instance.db_server.private_ip
}