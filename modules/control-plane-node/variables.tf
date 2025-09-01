variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
}

variable "subnet_id" {
  description = "subnet id"
  type = string
}

variable "cluster_token" {
  description = "k3s cluster token"
  type = string
}