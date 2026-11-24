variable "aws_region" {
  description = "AWS region to run in (e.g. us-east-1)"
  default     = "us-east-1"
}

variable "aws_access_key" {
  default = null
}

variable "aws_secret_key" {
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
