# network/vpc/outputs.tf

# ------------------ VPC ------------------
output "k8s_vpc_id" {
  description = "The Kubernetes AWS VPC ID"
  value       = aws_vpc.k8s.id
}

output "k8s_vpc_name" {
  description = "The Kubernetes AWS VPC name"
  value       = aws_vpc.k8s.tags_all.Name
}
