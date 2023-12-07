# network/internet_gateway/outputs.tf

output "k8s_internet_gateway_id" {
  description = "The Kuberntes VPC's Internet Gateway ID"
  value       = aws_internet_gateway.k8s.id
}
