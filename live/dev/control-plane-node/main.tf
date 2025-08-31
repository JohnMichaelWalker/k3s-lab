# this is populated by github action
terraform {
  backend "s3" {}
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

module "control-plane-node" {
  source   = "../../../modules/control-plane-node"
  vpc_cidr = "172.31.0.0/16"
  subnet_id = "subnet-0540e75f"
}