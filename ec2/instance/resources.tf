# ec2/instance/resources.tf

locals {
  # Control Planes
  k8s_public_control_plane_instances_final = flatten([
    for key, value in var.k8s_control_plane_instances :
    value if value.type == "public"
  ])
  k8s_private_control_plane_instances_final = flatten([
    for key, value in var.k8s_control_plane_instances :
    value if value.type == "private"
  ])
  # Worker Nodes
  k8s_public_worker_node_instances_final = flatten([
    for key, value in var.k8s_worker_node_instances :
    value if value.type == "public"
  ])
  k8s_private_worker_node_instances_final = flatten([
    for key, value in var.k8s_worker_node_instances :
    value if value.type == "private"
  ])
}

# ------------------ Control Planes ------------------
resource "aws_instance" "public_control_plane" {
  count                  = length(local.k8s_public_control_plane_instances_final)
  ami                    = var.k8s_ec2_instance_ami
  instance_type          = local.k8s_public_control_plane_instances_final[count.index].instance_type
  subnet_id              = lookup(var.k8s_all_kubernetes_subnet_type_to_id, "public@control_plane@${lookup(local.k8s_public_control_plane_instances_final[count.index], "az_filter", "a")}@${local.k8s_public_control_plane_instances_final[count.index].subnet_usage_filter}", "")
  vpc_security_group_ids = var.k8s_public_control_plane_security_group_ids

  associate_public_ip_address = true
  key_name                    = var.k8s_key_pair_key_name

  # Name: {group}-{env}-[{scope}]
  tags = merge(
    tomap(
      { "Name"        = "kubernetes-${var.k8s_common_tags.stage}-public-controlplane-${count.index}",
        "usage"       = "control_plane",
        "usage_extra" = "${local.k8s_public_control_plane_instances_final[count.index].subnet_usage_filter}",
        "type"        = "public",
        "az"          = "${local.k8s_public_control_plane_instances_final[count.index].az_filter}",
      }
    ),
  var.k8s_common_tags)

  // TODO parametrize user_data
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install apache2 -y
              EOF
}

resource "aws_instance" "private_control_plane" {
  count         = length(local.k8s_private_control_plane_instances_final)
  ami           = var.k8s_ec2_instance_ami
  instance_type = local.k8s_private_control_plane_instances_final[count.index].instance_type
  subnet_id     = lookup(var.k8s_all_kubernetes_subnet_type_to_id, "private@control_plane@${lookup(local.k8s_private_control_plane_instances_final[count.index], "az_filter", "a")}@${local.k8s_private_control_plane_instances_final[count.index].subnet_usage_filter}", "")

  vpc_security_group_ids = var.k8s_private_control_plane_security_group_ids

  associate_public_ip_address = !var.k8s_use_real_private_aws_subnets
  key_name                    = var.k8s_key_pair_key_name
  iam_instance_profile        = var.k8s_ec2_ssm_instance_profile_name

  # Name: {group}-{env}-[{scope}]
  tags = merge(
    tomap(
      { "Name"        = "kubernetes-${var.k8s_common_tags.stage}-private-controlplane-${count.index}",
        "usage"       = "control_plane",
        "usage_extra" = "${local.k8s_private_control_plane_instances_final[count.index].subnet_usage_filter}",
        "type"        = "private",
        "az"          = "${local.k8s_private_control_plane_instances_final[count.index].az_filter}",
      }
    ),
  var.k8s_common_tags)

  // TODO parametrize user_data
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install apache2 -y
              EOF
}

# ------------------ Worker Nodes ------------------
resource "aws_instance" "public_worker_node" {
  count         = length(local.k8s_public_worker_node_instances_final)
  ami           = var.k8s_ec2_instance_ami
  instance_type = local.k8s_public_worker_node_instances_final[count.index].instance_type
  subnet_id     = lookup(var.k8s_all_kubernetes_subnet_type_to_id, "public@worker_node@${lookup(local.k8s_public_worker_node_instances_final[count.index], "az_filter", "a")}@${local.k8s_public_worker_node_instances_final[count.index].subnet_usage_filter}", "")

  vpc_security_group_ids = var.k8s_public_worker_node_security_group_ids

  associate_public_ip_address = true
  key_name                    = var.k8s_key_pair_key_name

  # Name: {group}-{env}-[{scope}]
  tags = merge(
    tomap(
      { "Name"        = "kubernetes-${var.k8s_common_tags.stage}-public-workernode-${count.index}",
        "usage"       = "worker_node",
        "usage_extra" = "${local.k8s_public_worker_node_instances_final[count.index].subnet_usage_filter}",
        "type"        = "public",
        "az"          = "${local.k8s_public_worker_node_instances_final[count.index].az_filter}",
      }
    ),
  var.k8s_common_tags)

  // TODO parametrize user_data
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install apache2 -y
              EOF
}

resource "aws_instance" "private_worker_node" {
  count                  = length(local.k8s_private_worker_node_instances_final)
  ami                    = var.k8s_ec2_instance_ami
  instance_type          = local.k8s_private_worker_node_instances_final[count.index].instance_type
  subnet_id              = lookup(var.k8s_all_kubernetes_subnet_type_to_id, "private@worker_node@${lookup(local.k8s_private_worker_node_instances_final[count.index], "az_filter", "a")}@${local.k8s_private_worker_node_instances_final[count.index].subnet_usage_filter}", "")
  vpc_security_group_ids = var.k8s_private_worker_node_security_group_ids

  associate_public_ip_address = !var.k8s_use_real_private_aws_subnets
  key_name                    = var.k8s_key_pair_key_name
  iam_instance_profile        = var.k8s_ec2_ssm_instance_profile_name

  # Name: {group}-{env}-[{scope}]
  tags = merge(
    tomap(
      { "Name"        = "kubernetes-${var.k8s_common_tags.stage}-private-workernode-${count.index}",
        "usage"       = "worker_node",
        "usage_extra" = "${local.k8s_private_worker_node_instances_final[count.index].subnet_usage_filter}",
        "type"        = "private",
        "az"          = "${local.k8s_private_worker_node_instances_final[count.index].az_filter}",
      }
    ),
  var.k8s_common_tags)

  // TODO parametrize user_data
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install apache2 -y
              EOF
}
