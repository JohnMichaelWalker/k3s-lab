variable "aws_region" {
  description = "AWS region to deploy into"
  type = string
  default = "eu-west-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
  default = "172.31.0.0/16"
}