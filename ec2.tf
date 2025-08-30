module "ec2_instance" {
  source        = "terraform-aws-modules/ec2-instance/aws"
  name          = "k3s-instance-1"
  instance_type = "t4g.small"
  ami           = "ami-09b024e886d7bbe74"
  key_name      = "k3s-lab"
  subnet_id     = "subnet-0540e75f"
}

# For SSH Admin Access (public...)
resource "aws_security_group_rule" "allow_ssh" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.ec2_instance.security_group_id
}

# For k8s APi (e.g. kubectl) (public...)
resource "aws_security_group_rule" "allow_k8s_api" {
  type      = "ingress"
  from_port = 6443
  to_port   = 6443
  protocol  = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.ec2_instance.security_group_id
}
#
# # For multi-node-internal-traffic (not public)
# resource "aws_security_group_rule" "allow_flannel_vxlan_overlay" {
#   type      = "ingress"
#   from_port = 8472
#   to_port   = 8472
#   protocol  = "udp"
#   cidr_blocks = [var.vpc_cidr]
#   security_group_id = module.ec2_instance.security_group_id
# }
#
# # For multi-node-internal-traffic (not public)
# resource "aws_security_group_rule" "allow_kubelet" {
#   type      = "ingress"
#   from_port = 10250
#   to_port   = 10250
#   protocol  = "tcp"
#   cidr_blocks = [var.vpc_cidr]
#   security_group_id = module.ec2_instance.security_group_id
# }