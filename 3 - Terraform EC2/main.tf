terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.13.0"
    }
  }
}


provider "aws" {
	region = var.region
	access_key = var.my_access_key
	secret_key = var.my_secret_key
}

data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220426.0-x86_64-gp2"]
  }
  owners = ["137112412989"] # Canonical

}

resource "aws_instance" "example" {
    ami = data.aws_ami.amazon.id
	instance_type = "t2.micro"

    ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 8 
    volume_type = "gp2"
    }
    tags = {
        Name = "EC2 PRUEBA TECNICA BOCC"
    }
    vpc_security_group_ids = [aws_security_group.instance.id]
}

resource "aws_security_group" "instance" {
	name = "terraform-tcp-security-group"

	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}