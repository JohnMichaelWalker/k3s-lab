terraform {
  backend "s3" {}
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      Project     = "k3s-lab"
      Environment = "dev"
      ManagedBy   = "terraform"
      Role        = "control-plane-node"
    }
  }
}

resource "random_password" "k3s_token" {
  length  = 48
  special = false
}

module "control-plane-node" {
  source        = "../../../modules/control-plane-node"
  vpc_cidr      = "172.31.0.0/16"
  subnet_id     = "subnet-0540e75f"
  cluster_token = random_password.k3s_token.result
}

module "worker-node" {
  name                     = "worker-node-1"
  source                   = "../../../modules/worker-node"
  vpc_cidr                 = "172.31.0.0/16"
  subnet_id                = "subnet-0540e75f"
  cluster_token            = random_password.k3s_token.result
  control_plane_private_ip = module.control-plane-node.control_plane_ip
}