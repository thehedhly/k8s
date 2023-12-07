# network/route_table/outputs.tf

output "k8s_internet_gateway_access_route_table_id" {
  description = "The ID of AWS Route Table used for accessing the internet from the Kubernetes AWS Subnets"
  value       = aws_route_table.k8s_internet_gateway_access.id
}

output "k8s_nat_gateway_access_route_table_id" {
  description = "The ID of AWS Route Table used for accessing NAT Gateway from the Kubernetes AWS Subnets"
  value = tomap({
    for route_table in aws_route_table.k8s_nat_gateway_access : "${route_table.tags_all.az}" => route_table.id
  })
}
