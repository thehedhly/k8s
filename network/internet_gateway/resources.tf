# network/internet_gateway/resources.tf

resource "aws_internet_gateway" "k8s" {
  vpc_id = var.k8s_vpc_id

  # Name: {group}-{env}-[{scope}]-igw
  tags = merge(tomap({ "Name" = "kubernetes-${var.k8s_common_tags.stage}-igw" }), var.k8s_common_tags)
}
