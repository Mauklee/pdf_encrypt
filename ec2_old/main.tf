terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "default"
  
}
# VPC configuration
resource "aws_vpc" "pdf_encrypt_vpc" {
  cidr_block = "10.0.0.0/16"  # Change this to your desired CIDR block

  tags = {
    Name = "pdf_encrypt_vpc"
  }
}


# Security group configuration
resource "aws_security_group" "pdf_encrypt_security_group" {
  name_prefix = "pdf_encrypt_security_group"
  vpc_id = aws_vpc.pdf_encrypt_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "pdf_encrypt_security_group"
  }
}
/*resource "tls_private_key" "key_pair" { #generate key pair in AWS
  algorithm = "RSA"
  rsa_bits  = 4096
}*/
# deprciated as this this stores keys in security state and can only be used in Demo
resource "aws_key_pair" "key_pair" { #Creating keypair
  key_name = "var.key_pair_name"
  public_key = file(demokey.pub)
}

# Subnet configuration
resource "aws_subnet" "pdf_encrypt_subnet" {
  vpc_id     = aws_vpc.pdf_encrypt_vpc.id
  cidr_block = "10.0.1.0/24"  # Change this to your desired CIDR block

  tags = {
    Name = "pdf_encrypt_subnet"
  }
}
# EC2 instance configuration
resource "aws_instance" "pdf_encrypt_instance" {
  ami           = var.iam  # Change this to your desired AMI
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.pdf_encrypt_security_group.id]
  subnet_id     = aws_subnet.pdf_encrypt_subnet.id
  key_name      = aws_key_pair.key_pair.key_name

  user_data = <<-EOF
              #!/bin/bash
              mkdir pdfencrypt
              git clone https://github.com/openwall/john
              cd john/src
              sudo apt-get update
              sudo apt install libssl-dev
              ./configure && make
              cd ..
              cd ./run
              export PATH=$PATH:./
              EOF

  tags = {
    Name = "pdf_encrypt_instance"
  }
}
