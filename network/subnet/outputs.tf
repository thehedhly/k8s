# network/subnet/outputs.tf

# Control Plane subnets
output "k8s_control_plane_public_subnet_id" {
  description = "The IDs of all public Kubernetes control plane subnets"
  value = [
    for subnet in aws_subnet.k8s_control_plane_public : subnet.id
  ]
}

output "k8s_control_plane_private_subnet_id" {
  description = "The IDs of all private Kubernetes control plane subnets"
  value = [
    for subnet in aws_subnet.k8s_control_plane_private : subnet.id
  ]
}

# Worker Node subnets
output "k8s_worker_node_public_subnet_id" {
  description = "The IDs of all public Worker node subnets"
  value = [
    for subnet in aws_subnet.k8s_worker_node_public : subnet.id
  ]
}

output "k8s_worker_node_private_subnet_id" {
  description = "The IDs of all private Kubernetes worker node subnets"
  value = [
    for subnet in aws_subnet.k8s_worker_node_private : subnet.id
  ]
}

output "k8s_control_plane_subnets_cidr_blocks" {
  description = "The IPv4 CIDR blocks of all Kubernetes control plane subnets"
  value = [
    for cidr_block in local.k8s_control_plane_subnets_cidr_blocks : cidr_block
  ]
}

output "k8s_worker_node_subnets_cidr_blocks" {
  description = "The IPv4 CIDR blocks of all Kubernetes worker node subnets"
  value = [
    for cidr_block in local.k8s_worker_node_subnets_cidr_blocks : cidr_block
  ]
}

output "k8s_all_kubernetes_subnets_cidr_blocks" {
  description = "The IPv4 CIDR blocks of all Kubernetes subnets (excluding the NAT subnets)"
  value = [
    for cidr_block in local.k8s_all_kubernetes_subnets_cidr_blocks : cidr_block
  ]
}

output "k8s_all_subnets_cidr_blocks" {
  description = "The IPv4 CIDR blocks of all Kubernetes subnets (including the NAT subnets)"
  value = concat(
    [for cidr_block in local.k8s_all_kubernetes_subnets_cidr_blocks : cidr_block],
    [for az, cidr_block in var.k8s_nat_subnets : cidr_block] #don't use value(map)
  )
}

# NAT subnets
output "k8s_nat_subnet_id_az" {
  description = "The IDs of all NAT subnets mapped to their availability zone"
  value = tomap({
    for k, value in aws_subnet.k8s_nat : "${value.tags_all.az}" => value.id
  })
}

# All subnets
output "k8s_all_kubernetes_public_subnet_id" {
  description = "The IDs of all public Kubernetes subnets (excluding the NAT subnets)"
  value = concat(
    [
      for subnet in aws_subnet.k8s_control_plane_public : subnet.id
    ],
    [
      for subnet in aws_subnet.k8s_worker_node_public : subnet.id
    ],
  )
}

output "k8s_all_public_subnet_id" {
  description = "The IDs of all public subnets (including the NAT subnets)"
  value = concat(
    [
      for subnet in aws_subnet.k8s_control_plane_public : subnet.id
    ],
    [
      for subnet in aws_subnet.k8s_worker_node_public : subnet.id
    ],
    [
      for subnet in aws_subnet.k8s_nat : subnet.id
    ],
  )
}

output "k8s_all_kubernetes_private_subnet_id" {
  description = "The IDs of all private Kubernetes subnets (excluding the NAT subnets)"
  value = concat(
    [
      for subnet in aws_subnet.k8s_control_plane_private : subnet.id
    ],
    [
      for subnet in aws_subnet.k8s_worker_node_private : subnet.id
    ],
  )
}

output "k8s_all_kubernetes_private_subnet_id_az" {
  description = "The IDs of all private Kubernetes subnets mapped to their availability zones"
  value = concat(
    [
      for subnet in aws_subnet.k8s_control_plane_private : { "id" = "${subnet.id}", "az" = "${subnet.tags_all.az}" }
    ],
    [
      for subnet in aws_subnet.k8s_worker_node_private : { "id" = "${subnet.id}", "az" = "${subnet.tags_all.az}" }
    ],
  )
}

output "k8s_all_kubernetes_subnet_id" {
  description = "The IDs of all Kubernetes subnets (excluding the NAT subnets)"
  value = concat(
    [
      for subnet in aws_subnet.k8s_control_plane_public : subnet.id
    ],
    [
      for subnet in aws_subnet.k8s_control_plane_private : subnet.id
    ],
    [
      for subnet in aws_subnet.k8s_worker_node_public : subnet.id
    ],
    [
      for subnet in aws_subnet.k8s_worker_node_private : subnet.id
    ],
  )
}

output "k8s_all_subnet_id" {
  description = "The IDs of all subnets (including the NAT subnets)"
  value = concat(
    [
      for subnet in aws_subnet.k8s_control_plane_public : subnet.id
    ],
    [
      for subnet in aws_subnet.k8s_control_plane_private : subnet.id
    ],
    [
      for subnet in aws_subnet.k8s_worker_node_public : subnet.id
    ],
    [
      for subnet in aws_subnet.k8s_worker_node_private : subnet.id
    ],
    [
      for subnet in aws_subnet.k8s_nat : subnet.id
    ],
  )
}

output "k8s_all_kubernetes_subnet_type_to_id" {
  description = "Subnet mapping (excluding the NAT subnets) in the form of \"[subnet type: public/private]@[subnet usage: control_plane/worker_node]@[Availability zone: a/b/c]@[subnet usage extra: *]\" to \"[subnet ID]\""
  value = merge(
    {
      for subnet in aws_subnet.k8s_control_plane_public : "${subnet.tags.type}@${subnet.tags.usage}@${subnet.tags.az}@${subnet.tags.usage_extra}" => subnet.id
    },
    {
      for subnet in aws_subnet.k8s_control_plane_private : "${subnet.tags.type}@${subnet.tags.usage}@${subnet.tags.az}@${subnet.tags.usage_extra}" => subnet.id
    },
    {
      for subnet in aws_subnet.k8s_worker_node_public : "${subnet.tags.type}@${subnet.tags.usage}@${subnet.tags.az}@${subnet.tags.usage_extra}" => subnet.id
    },
    {
      for subnet in aws_subnet.k8s_worker_node_private : "${subnet.tags.type}@${subnet.tags.usage}@${subnet.tags.az}@${subnet.tags.usage_extra}" => subnet.id
    },
  )
}
