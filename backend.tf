terraform {
  backend "s3" {
    bucket         = "k3s-lab-terraform-state"
    key            = "k3s-lab/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "boss-eks-lab-terraform-locks"
    encrypt        = true
  }
}