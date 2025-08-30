module "ec2_instance" {
  source        = "terraform-aws-modules/ec2-instance/aws"
  name          = "k3s-instance-1"
  instance_type = "t3.micro"
  key_name      = "k3s-lab"
  subnet_id     = "subnet-0540e75f"
}

resource "aws_security_group_rule" "allow_ssh" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.ec2_instance.security_group_id
}