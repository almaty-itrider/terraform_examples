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

  # Отдельное правило для какого нибудь IP адреса, то есть это правило относится только к одному хосту
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
