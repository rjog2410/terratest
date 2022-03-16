variable "AWS_ACCESS_KEY_ID" {
    type = string
    description=""
}
variable "AWS_SECRET_ACCESS_KEY" {
    type = string
    description=""
}

provider "aws" {
  region     = "us-east-2"
  access_key = AWS_ACCESS_KEY_ID
  secret_key = AWS_SECRET_ACCESS_KEY
}

resource "aws_instance" "instance-terraformcloud" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  tags = {
    Name = "terraformcloud"
  }
}
