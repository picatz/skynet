# Create a new instance of the latest Centos 7 on an t2.micro node
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  
  owners      = ["679593333241"] # CentOS
}

resource "aws_security_group" "skynet" {
  name        = "skynet"
  description = "Allow all inbound traffic from Eastern Michigan University"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.allow_ip}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Adds SSH access"
  }
}

resource "aws_key_pair" "skynet" {
  key_name   = "skynet"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "ec2_instance" {
  ami                    = "${data.aws_ami.centos.id}"
  instance_type          = "t2.micro"
  availability_zone      = "${var.aws_region}"
  vpc_security_group_ids = ["${aws_security_group.skynet.id}"]
  key_name               = "skynet"
  tags {
    Name = "skynetTerraformExampleYo"
  }
}
