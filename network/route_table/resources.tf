# network/route_table/resources.tf

resource "aws_route_table" "k8s_internet_gateway_access" {
  vpc_id = var.k8s_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.k8s_internet_gateway_id
  }
  # Name: {group}-{env}-[{availibility_zone}]-{scope}-{routetype}-rt
  tags = merge(tomap({ "Name" = "kubernetes-${var.k8s_common_tags.stage}-${var.k8s_region}-public-rtb" }), var.k8s_common_tags)
}

resource "aws_route_table" "k8s_nat_gateway_access" {

  for_each = {
    for availability_zone, nat in var.k8s_nat_az :
    "kubernetes-${var.k8s_common_tags.stage}-${var.k8s_region}${availability_zone}-private-rtb" => { "id" = "${nat.id}", "az" = "${availability_zone}" }
  }

  vpc_id = var.k8s_vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = each.value.id
  }
  # Name: {group}-{env}-[{availibility_zone}]-{scope}-{routetype}-rt
  tags = merge(tomap({ "Name" = "${each.key}", "az" = "${each.value.az}", "az_full" = "${var.k8s_region}${each.value.id}" }), var.k8s_common_tags)
}
