# network/route_table_association/outputs.tf

output "k8s_aws_route_table_association_internet_access_for_all_subnet" {
  description = "IDs of the internet route table association for all subnets"
  value = [
    for association in aws_route_table_association.k8s_internet_access_for_all_subnet : association.id
  ]
}
