# -----------------------------------------
# My Terraform
#
# Build WebServer during Bootstrap
#
# Made by Abylay Kuvatov
# -----------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "MyWebServer" {
  ami                    = "ami-0e872aee57663ae2d" # Ubuntu Server AMI
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  user_data              = file("./user_data.sh")

  tags = {
    Name  = "Web Server"
    Owner = "Abylay"
  }
}

resource "aws_security_group" "allow_http" {
  name = "WebServer Security Group"

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

  tags = {
    Name = "WebServer Security Group"
  }
}
