module "ec2_instance" {
  source        = "terraform-aws-modules/ec2-instance/aws"
  name          = "k3s-instance-1"
  instance_type = "t4g.small"
  ami           = "ami-0bec58f5985730abf"
  key_name      = "k3s-lab"
  subnet_id     = var.subnet_id
  user_data_replace_on_change = true
  user_data = <<-EOF
              #!/bin/bash
              set -e
              yum update -y
              yum install -y curl
              curl -sfL https://get.k3s.io | sh -
              mkdir -p /root/k3s
              cp /var/lib/rancher/k3s/server/node-token /root/k3s/node-token
              ln -s /usr/local/bin/kubectl /usr/bin/kubectl
              EOF
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

# For multi-node-internal-traffic (not public)
resource "aws_security_group_rule" "allow_flannel_vxlan_overlay" {
  type      = "ingress"
  from_port = 8472
  to_port   = 8472
  protocol  = "udp"
  cidr_blocks = [var.vpc_cidr]
  security_group_id = module.ec2_instance.security_group_id
}

# For multi-node-internal-traffic (not public)
resource "aws_security_group_rule" "allow_kubelet" {
  type      = "ingress"
  from_port = 10250
  to_port   = 10250
  protocol  = "tcp"
  cidr_blocks = [var.vpc_cidr]
  security_group_id = module.ec2_instance.security_group_id
}