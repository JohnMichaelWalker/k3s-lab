output "control_plane_ip" {
  value = module.ec2_instance.private_ip
}

output "join_token_command" {
  value = "sudo k3s agent --server https://${module.ec2_instance.private_ip}:6443 --token $(cat /var/lib/rancher/k3s/server/node-token)"
}