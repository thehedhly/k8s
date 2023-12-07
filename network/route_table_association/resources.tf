# network/route_table_association/resources.tf

resource "aws_route_table_association" "k8s_internet_access_for_all_subnet" {
  count = var.k8s_use_real_private_aws_subnets ? 0 : length(var.k8s_all_kubernetes_subnet_id)

  subnet_id      = var.k8s_all_kubernetes_subnet_id[count.index]
  route_table_id = var.k8s_internet_gateway_access_route_table_id
}

resource "aws_route_table_association" "k8s_internet_access_for_public_subnet" {
  count = var.k8s_use_real_private_aws_subnets ? length(var.k8s_all_public_subnet_id) : 0

  subnet_id      = var.k8s_all_public_subnet_id[count.index]
  route_table_id = var.k8s_internet_gateway_access_route_table_id
}

resource "aws_route_table_association" "k8s_nat_access_for_private_subnet" {
  count = var.k8s_use_real_private_aws_subnets ? length(var.k8s_all_kubernetes_private_subnet_id_az) : 0

  subnet_id      = var.k8s_all_kubernetes_private_subnet_id_az[count.index].id
  route_table_id = var.k8s_nat_gateway_access_route_table_id[var.k8s_all_kubernetes_private_subnet_id_az[count.index].az]
}
