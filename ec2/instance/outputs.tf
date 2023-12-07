# ec2/instance/outputs.tf

# ------------------ Control Plane ------------------
output "k8s_public_control_planes" {
  description = "The list of created public Kubernetes control plane AWS EC2 instance(s). The details cover the ID, Name tag, public_ip, public_dns, usage tag and usage extra tag of the EC2 instance"
  value = [
    for control_plane in aws_instance.public_control_plane : {
      "id"          = control_plane.id,
      "name"        = control_plane.tags_all.Name,
      "public_ip"   = control_plane.public_ip,
      "public_dns"  = control_plane.public_dns
      "usage"       = control_plane.tags_all.usage,
      "usage_extra" = control_plane.tags_all.usage_extra
    }
  ]
}

output "k8s_private_control_planes" {
  description = "The list of created private Kubernetes control plane AWS EC2 instance(s). The details cover the ID, Name tag, public_ip, public_dns, usage tag and usage extra tag of the EC2 instance"
  value = [
    for control_plane in aws_instance.private_control_plane : {
      "id"          = control_plane.id,
      "name"        = control_plane.tags_all.Name,
      "public_ip"   = control_plane.public_ip,
      "public_dns"  = control_plane.public_dns
      "usage"       = control_plane.tags_all.usage,
      "usage_extra" = control_plane.tags_all.usage_extra
    }
  ]
}

# ------------------ Worker Node ------------------
output "k8s_public_worker_nodes" {
  description = "The list of created public Kubernetes worker node AWS EC2 instance(s). The details cover the ID, Name tag, public_ip, public_dns, usage tag and usage extra tag of the EC2 instance"
  value = [
    for worker_node in aws_instance.public_worker_node : {
      "id"          = worker_node.id,
      "name"        = worker_node.tags_all.Name,
      "public_ip"   = worker_node.public_ip,
      "public_dns"  = worker_node.public_dns
      "usage"       = worker_node.tags_all.usage,
      "usage_extra" = worker_node.tags_all.usage_extra
    }
  ]
}

output "k8s_private_worker_nodes" {
  description = "The list of created private Kubernetes worker node AWS EC2 instance(s). The details cover the ID, Name tag, public_ip, public_dns, usage tag and usage extra tag of the EC2 instance"
  value = [
    for worker_node in aws_instance.private_worker_node : {
      "id"          = worker_node.id,
      "name"        = worker_node.tags_all.Name,
      "public_ip"   = worker_node.public_ip,
      "public_dns"  = worker_node.public_dns
      "usage"       = worker_node.tags_all.usage,
      "usage_extra" = worker_node.tags_all.usage_extra
    }
  ]
}
