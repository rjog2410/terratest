variable "AWS_ACCESS_KEY_ID" {
  type = string
}
variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}

variable "bucket" {
  type    = string
  default = "buckets3rjog"
}

variable "content" {
  type    = string
  default = "Class terraform RJOG"
}

variable "region" {
  type    = string
  default = "us-east-2"
}

provider "aws" {
  region     = var.region
  profile    = "test_profile"
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
  acl          = "public-read"
  content      = var.content
  content_type = "text/html"
}
