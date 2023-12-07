# network/subnet/resources.tf

locals {
  # Control Plane subnets
  k8s_control_plane_public_subnets = flatten([
    for key, value in var.k8s_control_plane_subnets :
    value if value.type == "public"
  ])
  k8s_control_plane_private_subnets = flatten([
    for key, value in var.k8s_control_plane_subnets :
    value if value.type == "private"
  ])
  # Worker Node subnets
  k8s_worker_node_public_subnets = flatten([
    for key, value in var.k8s_worker_node_subnets :
    value if value.type == "public"
  ])
  k8s_worker_node_private_subnets = flatten([
    for key, value in var.k8s_worker_node_subnets :
    value if value.type == "private"
  ])

  # Control Plane subnets CIDR blocks
  k8s_control_plane_subnets_cidr_blocks = concat(
    sort(flatten([
      for key, value in local.k8s_control_plane_public_subnets :
      value.cidr_block
    ])),
    sort(flatten([
      for key, value in local.k8s_control_plane_private_subnets :
      value.cidr_block
    ]))
  )
  # Worker Node subnets CIDR blocks
  k8s_worker_node_subnets_cidr_blocks = concat(
    sort(flatten([
      for key, value in local.k8s_worker_node_public_subnets :
      value.cidr_block
    ])),
    sort(flatten([
      for key, value in local.k8s_worker_node_private_subnets :
      value.cidr_block
    ]))
  )
  # All CIDR blocks
  k8s_all_kubernetes_subnets_cidr_blocks = concat(
    sort(flatten([
      for key, value in var.k8s_control_plane_subnets :
      value.cidr_block
    ])),
    sort(flatten([
      for key, value in var.k8s_worker_node_subnets :
      value.cidr_block
    ]))
  )
}

# Control Plane subnets
resource "aws_subnet" "k8s_control_plane_public" {
  for_each = {
    for index, subnet in local.k8s_control_plane_public_subnets :
    "kubernetes-${var.k8s_common_tags.stage}-${var.k8s_region}${subnet.availability_zone}-controlplane-${subnet.usage_extra}-public" => subnet
  }
  vpc_id            = var.k8s_vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = "${var.k8s_region}${each.value.availability_zone}"

  # Name: {group}-{env}-{availibility_zone}-{scope}-{public|private}
  tags = merge(tomap({ "Name" = "${each.key}", "az" = "${each.value.availability_zone}", "usage" = "control_plane", "usage_extra" = "${each.value.usage_extra}", "type" = "public" }), var.k8s_common_tags)
}

resource "aws_subnet" "k8s_control_plane_private" {
  for_each = {
    for index, subnet in local.k8s_control_plane_private_subnets :
    "kubernetes-${var.k8s_common_tags.stage}-${var.k8s_region}${subnet.availability_zone}-controlplane-${subnet.usage_extra}-private" => subnet
  }
  vpc_id            = var.k8s_vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = "${var.k8s_region}${each.value.availability_zone}"

  # Name: {group}-{env}-{availibility_zone}-{scope}-{public|private}
  tags = merge(tomap({ "Name" = "${each.key}", "az" = "${each.value.availability_zone}", "usage" = "control_plane", "usage_extra" = "${each.value.usage_extra}", "type" = "private" }), var.k8s_common_tags)
}

# Worker Node subnets
resource "aws_subnet" "k8s_worker_node_public" {
  for_each = {
    for index, subnet in local.k8s_worker_node_public_subnets :
    "kubernetes-${var.k8s_common_tags.stage}-${var.k8s_region}${subnet.availability_zone}-workernode-${subnet.usage_extra}-public" => subnet
  }
  vpc_id            = var.k8s_vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = "${var.k8s_region}${each.value.availability_zone}"

  # Name: {group}-{env}-{availibility_zone}-{scope}-{public|private}
  tags = merge(tomap({ "Name" = "${each.key}", "az" = "${each.value.availability_zone}", "usage" = "worker_node", "usage_extra" = "${each.value.usage_extra}", "type" = "public" }), var.k8s_common_tags)
}

resource "aws_subnet" "k8s_worker_node_private" {
  for_each = {
    for index, subnet in local.k8s_worker_node_private_subnets :
    "kubernetes-${var.k8s_common_tags.stage}-${var.k8s_region}${subnet.availability_zone}-workernode-${subnet.usage_extra}-private" => subnet
  }
  vpc_id            = var.k8s_vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = "${var.k8s_region}${each.value.availability_zone}"

  # Name: {group}-{env}-{availibility_zone}-{scope}-{public|private}
  tags = merge(tomap({ "Name" = "${each.key}", "az" = "${each.value.availability_zone}", "usage" = "worker_node", "usage_extra" = "${each.value.usage_extra}", "type" = "private" }), var.k8s_common_tags)
}

# Public NAT Subnets (one for each AZ which contains at least one private subnet)
resource "aws_subnet" "k8s_nat" {
  for_each = {
    for availability_zone, cidr in var.k8s_nat_subnets :
    "common-${var.k8s_common_tags.stage}-${var.k8s_region}${availability_zone}-nat-public" => [availability_zone, cidr]
  }
  vpc_id            = var.k8s_vpc_id
  cidr_block        = each.value[1]
  availability_zone = "${var.k8s_region}${each.value[0]}"

  # Name: {group}-{env}-{availibility_zone}-{scope}-{public|private}
  tags = merge(tomap({ "Name" = "${each.key}", "az" = "${each.value[0]}", "usage" = "nat", "type" = "public" }), var.k8s_common_tags)
}
