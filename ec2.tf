# security group for ec2 instance
resource "aws_security_group" "windows_instance_sg" {
  name        = "${var.project}-windows-sg"
  description = "Allow RDP, HTTP and HTTPS inbound and outbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow HTTP inbound traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow RDP inbound traffic"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS inbound traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = {

    Name = "${var.project}-windows-sg"
  }
}


# security group for ec2 instance
resource "aws_security_group" "linux_instance_sg" {
  name        = "${var.project}-linux-sg"
  description = "Allow RDP, HTTP and HTTPS inbound and outbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow HTTP inbound traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH inbound traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS inbound traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = {

    Name = "${var.project}-linux-sg"
  }
}

# AMI for Windows 2016
data "aws_ami" "windows_2016" {
  most_recent = true


  filter {
    name   = "platform"
    values = ["windows"]
  }
  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Full-Base-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

# AMI for Amazon Linux 2
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}



resource "aws_instance" "linux_instance" {
  ami = data.aws_ami.amazon_linux_2.id
  #   ami             = 
  instance_type   = "t3.medium"
  subnet_id       = aws_subnet.public_subnet[0].id
  security_groups = [aws_security_group.linux_instance_sg.id]
  key_name        = "var.keypair"
  root_block_device {
    volume_size           = 50
    volume_type           = "gp3"
    delete_on_termination = true

  }
  associate_public_ip_address = true
  user_data                   = file("user-data.tpl")

  tags = {
    Name = "${var.project}-linux-instance"
  }
}
