terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# --- SECURITY GROUPS ---
resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "SSH depuis exterieur"
  vpc_id      = var.vpc-default-id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- INSTANCES EC2 ---

resource "aws_instance" "phase1" {
  ami                = var.ami_id
  instance_type      = "t3.micro"
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name           = var.key_name
  user_data = file("./UserdataScript-phase-2.sh")
  tags = {
    Name = "phase1"
  }
}
