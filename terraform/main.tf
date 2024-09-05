provider "aws" {
  region = var.region
}

//Creating required network resources for EC2
resource "aws_vpc" "app_vpc" {
  name       = "nginx_web_vpc"
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "app_subnet" {
  name              = "nginx_web_subnet"
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.subnet_az
}

resource "aws_security_group" "app_sg" {
  name        = "nginx_web_sg"
  description = "Allow all SSH and HTTP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.app_vpc.id
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

//Creating key pair to SSH into ec2 instance
resource "tls_private_key" "app-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "nginx_web_keypair" {
  key_name = "nginx_web_key"
  public_key = tls_private_key.app-key.public_key_openssh
}

//Creating EC2 instance
resource "aws_instance" "nginx_web" {
  ami                    = var.ami_id
  count                  = var.instance_count
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.app_subnet.id
  vpc_security_group_ids = aws_security_group.app_sg.id
  key_name               = "nginx_web_key"
  user_data              = file("./userdata.tpl")
}