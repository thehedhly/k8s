# network/vpc/resources.tf

resource "aws_vpc" "k8s" {
  cidr_block           = var.k8s_vpc_cidr_block
  enable_dns_hostnames = var.k8s_vpc_enable_dns_hostnames

  # Name: {group}-{env}-{scope}-vpc
  tags = merge(
    tomap({ "Name" = "kubernetes-${var.k8s_common_tags.stage}-${var.k8s_region}-vpc" }),
    var.k8s_common_tags
  )
}
