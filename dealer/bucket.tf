variable "AWS_ACCESS_KEY_ID" {
  type = string
}
variable "AWS_SECRET_ACCESS_KEY" {
  type        = string
  description = ""
}

variable "bucket" {
  type  = string
  value = "Bucket S3 RJOG"
}

variable "content" {
  type  = string
  value = "Class terraform RJOG"
}

variable "region" {
  type  = string
  value = "us-east-2"
}

provider "aws" {
  region     = var.region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

resource "aws_s3_bucket" "bucket1" {
  bucket = var.bucket
  acl    = "public-read"
  website {
    index_document = "index.html"
  }
}
resource "aws_s3_bucket_object" "object1" {
  bucket       = aws_s3_bucket.bucket1.bucket
  key          = "index.html"
  content      = var.content
  content_type = "text/html"
}
