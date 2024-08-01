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

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.MyWebServer.id
}

resource "aws_instance" "MyWebServer" {
  ami                    = "ami-0e872aee57663ae2d" # Ubuntu Server AMI
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  user_data = templatefile("./user_data.sh.tpl", {
    f_name = "Abylay",
    l_name = "Kuvatov",
    names  = ["German", "Alibek", "Bekaidar", "Sasha"]
  })

  tags = {
    Name  = "Web Server Build by Terraform"
    Owner = "Abylay"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "allow_http" {
  name = "Dynamic Security Group"

  dynamic "ingress" {
    for_each = ["80", "443", "8080"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

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
    Name = "Dynamic Security Group"
  }
}
