# # network/elastic_ip/outputs.tf

output "k8s_nat_eip_az" {
  description = "The IDs & Allocation IDs of all NAT Elastic IP addresses mapped to their NAT availability zone"
  value = tomap({
    for k, value in aws_eip.nat : "${value.tags_all.az}" => { "id" = "${value.id}", "allocation_id" = "${value.allocation_id}" }
  })
}
