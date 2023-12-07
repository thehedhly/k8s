# network/elastic_ip/resources.tf

resource "aws_eip" "nat" {
  for_each = {
    for availability_zone, cidr in var.k8s_nat_subnets :
    "kubernetes-${var.k8s_region}${availability_zone}-${var.k8s_common_tags.stage}-eip" => availability_zone
  }
  public_ipv4_pool = "amazon"
  domain           = "vpc"
  # Name: {group}-{env}-[{availibility_zone}]-[{scope}]-eip
  tags = merge(tomap({ "Name" = "${each.key}", "az_full" = "${var.k8s_region}${each.value}", "az" = "${each.value}", "usage" = "nat" }), var.k8s_common_tags)
}
