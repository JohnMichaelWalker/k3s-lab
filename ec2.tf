module "ec2_instance" {
  source        = "terraform-aws-modules/ec2-instance/aws"
  name          = "k3s-instance-1"
  instance_type = "t3.micro"
  key_name      = "user1"
  subnet_id     = "subnet-0540e75f"
}