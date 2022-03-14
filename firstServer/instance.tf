terraform {
    required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~>3.0"
      }
    }
}

provider "aws" {
    access_key = "AKIAX7RIUA7A2SAZFHWJ"
    secret_key = "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"
    region = "us-east-2"
}

resource "aws_instance" "hello-instance" {
    ami = "ami-0fb653ca2d3203ac1"
    instance_type = "t2.micro"
    tags = {
        Name = "hello-instance"
    }
}