provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_ubuntu" {
  ami           = "ami-0e872aee57663ae2d"
  instance_type = "t3.micro"
  count         = 2

  tags = {
    Name    = "Test Ubuntu Server"
    Owner   = "Abylay"
    Project = "Terraform Lessons"
  }
}
