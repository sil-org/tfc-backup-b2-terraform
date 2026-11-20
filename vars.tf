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

variable "app_name" {
  default = "tfcbackup"
}

variable "tf_remote_organization" {
}

variable "tf_remote_common_workspace" {
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "customer" {
  description = "Customer name, used in AWS tags"
  type        = string
}
