# network/nat_gateway/resources.tf

resource "aws_nat_gateway" "k8s_public" {

  for_each = {
    for availability_zone, subnet_id in var.k8s_nat_subnet_id_az :
    "kubernetes-${var.k8s_common_tags.stage}-${var.k8s_region}${availability_zone}-ngw" => { "subnet_id" = "${subnet_id}", "eip_id" = "${var.k8s_nat_eip_az[availability_zone].allocation_id}", "az" = "${availability_zone}" }
  }

  connectivity_type = "public"
  allocation_id     = each.value.eip_id
  subnet_id         = each.value.subnet_id
  # Name: {group}-{env}-[{scope}]-ngw
  tags = merge(tomap({ "Name" = "${each.key}", "az_full" = "${var.k8s_region}${each.value.az}", "az" = "${each.value.az}", "usage" = "nat" }), var.k8s_common_tags)
}
