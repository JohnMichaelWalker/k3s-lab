# gets the default vpc
data "aws_vpc" "default" {
  default = true
}

# gets default subnet ids
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

module "ec2_instance" {
  source        = "terraform-aws-modules/ec2-instance/aws"
  name          = "k3s-instance-1"
  instance_type = "t3.micro"
  key_name      = "user1"
  subnet_id     = tolist(data.aws_subnet_ids.default.ids)[0]
}