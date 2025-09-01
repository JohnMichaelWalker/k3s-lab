variable "name" {
  description = "name"
  type = string
}

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

variable "control_plane_private_ip" {
  description = "private ip of control plane"
  type = string
}