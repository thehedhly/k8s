# # network/nat_gateway/outputs.tf

output "k8s_nat_az" {
  description = "The IDs of all NAT mapped to their NAT availability zone"
  value = tomap({
    for k, value in aws_nat_gateway.k8s_public : "${value.tags_all.az}" => { "id" = "${value.id}", "public_ip" = "${value.public_ip}" }
  })
}
