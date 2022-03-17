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
