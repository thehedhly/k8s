# k8s/outputs.tf

# ------------------ VPC ------------------
output "k8s_vpc_id" {
  description = "The Kubernetes AWS VPC ID"
  value       = module.k8s_network_vpc.k8s_vpc_id
}

output "k8s_vpc_name" {
  description = "The Kubernetes AWS VPC name"
  value       = module.k8s_network_vpc.k8s_vpc_name
}

# ------------------ Subnet ------------------
output "k8s_all_kubernetes_subnet_id" {
  description = "The IDs of all Kubernetes subnets (excluding the NAT subnets)"
  value       = module.k8s_network_subnet.k8s_all_kubernetes_subnet_id
}

output "k8s_all_subnet_id" {
  description = "The IDs of all subnets (including the NAT subnets)"
  value       = module.k8s_network_subnet.k8s_all_subnet_id
}

output "k8s_nat_subnet_id_az" {
  description = "The IDs of all NAT subnets mapped to their availability zone"
  value       = module.k8s_network_subnet.k8s_nat_subnet_id_az
}

output "k8s_all_kubernetes_private_subnet_id_az" {
  description = "The IDs of all private Kubernetes subnets mapped to their availability zones"
  value       = module.k8s_network_subnet.k8s_all_kubernetes_private_subnet_id_az
}

# ------------------ Elastic IP address ------------------
output "k8s_nat_eip_az" {
  description = "The IDs of all Elastic IP addresses to be used for creating the NATs"
  value       = module.k8s_network_elastic_ip.k8s_nat_eip_az
}

# ------------------ Internet Gateway ------------------
output "k8s_internet_gateway_id" {
  description = "The Kuberntes VPC's Internet Gateway ID"
  value       = module.k8s_network_internet_gateway.k8s_internet_gateway_id
}

# ------------------ NAT Gateway ------------------
output "k8s_nat_az" {
  description = "The IDs of all NAT mapped to their NAT availability zone"
  value       = module.k8s_network_nat_gateway.k8s_nat_az
}

# ------------------ Internet Access Route Table ------------------
output "k8s_internet_gateway_access_route_table_id" {
  description = "The ID of AWS Route Table used for accessing the internet from the Kubernetes AWS Subnets"
  value       = module.k8s_network_route_table.k8s_internet_gateway_access_route_table_id
}

# ------------------ NAT Access Route Table ------------------
output "k8s_nat_gateway_access_route_table_id" {
  description = "The ID of AWS Route Table used for accessing NAT Gateway from the Kubernetes AWS Subnets"
  value       = module.k8s_network_route_table.k8s_nat_gateway_access_route_table_id
}

# ------------------ Security Group ------------------
output "k8s_public_control_plane_security_group_ids" {
  description = "The IDs of all AWS security groups to be used by public Kubernetes control planes"
  value       = module.k8s_network_security_group.k8s_public_control_plane_security_group_ids
}

output "k8s_private_control_plane_security_group_ids" {
  description = "The IDs of all AWS security groups to be used by private Kubernetes control planes"
  value       = module.k8s_network_security_group.k8s_private_control_plane_security_group_ids
}

output "k8s_public_worker_node_security_group_ids" {
  description = "The IDs of all AWS security groups to be used by public Kubernetes worker nodes"
  value       = module.k8s_network_security_group.k8s_public_worker_node_security_group_ids
}

output "k8s_private_worker_node_security_group_ids" {
  description = "The IDs of all AWS security groups to be used by private Kubernetes worker nodes"
  value       = module.k8s_network_security_group.k8s_private_worker_node_security_group_ids
}

# ------------------ EC2 Key pair ------------------
output "k8s_key_pair_key_name" {
  description = "The AWS key pair which will be provided to the Kubernetes AWS EC2 instance(s) on provisioing"
  value       = module.k8s_ec2_key_pair.k8s_key_pair_key_name
}

# ------------------ EC2 Instance ------------------
output "k8s_public_control_planes" {
  description = "The list of created public Kubernetes control plane AWS EC2 instance(s). The details cover the ID, public_ip, Name tag, usage tag and usage extra tag of the EC2 instance"
  value       = module.k8s_ec2_instance.k8s_public_control_planes
}

output "k8s_private_control_planes" {
  description = "The list of created private Kubernetes control plane AWS EC2 instance(s). The details cover the ID, public_ip, Name tag, usage tag and usage extra tag of the EC2 instance"
  value       = module.k8s_ec2_instance.k8s_private_control_planes
}

output "k8s_public_worker_nodes" {
  description = "The list of created public Kubernetes worker node AWS EC2 instance(s). The details cover the ID, public_ip, Name tag, usage tag and usage extra tag of the EC2 instance"
  value       = module.k8s_ec2_instance.k8s_public_worker_nodes
}

output "k8s_private_worker_nodes" {
  description = "The list of created private Kubernetes worker node AWS EC2 instance(s). The details cover the ID, public_ip, Name tag, usage tag and usage extra tag of the EC2 instance"
  value       = module.k8s_ec2_instance.k8s_private_worker_nodes
}
