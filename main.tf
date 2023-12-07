# k8s/main.tf

locals {
  # Private control plane's avaibilty zones
  k8s_private_control_plane_az = [
    for key, value in var.k8s_control_plane_subnets :
    value.availability_zone if value.type == "private"
  ]
  # Private worker node's avaibilty zones
  k8s_private_worker_node_az = [
    for key, value in var.k8s_worker_node_subnets :
    value.availability_zone if value.type == "private"
  ]
  # All Avaibilty zones having at least one private control-plane or worker-node subnet
  k8s_az_with_private_subnet = setunion(local.k8s_private_control_plane_az, local.k8s_private_worker_node_az)
  # NAT subnet's avaibilty zones
  k8s_nat_subnet_azs = keys(var.k8s_nat_subnets)
}

# ------------------ AWS Provider ------------------
provider "aws" {
  region  = var.k8s_region
  profile = var.k8s_profile
}

data "aws_region" "current" {
  lifecycle {
    # Pre-Validations
    precondition {
      condition     = var.k8s_use_real_private_aws_subnets ? sort(local.k8s_nat_subnet_azs) == sort(local.k8s_az_with_private_subnet) : length(local.k8s_nat_subnet_azs) == 0
      error_message = <<-EOF
                  If 'k8s_use_real_private_aws_subnets' flag is :
                    - enabled "true": make sure one NAT Subnet for each availability zone having at least one private subnet is provided
                    - disabled "false": no NAT Subnet should be provided
                  EOF
    }
  }
}

# ------------------ VPC ------------------
module "k8s_network_vpc" {
  source             = "./network/vpc"
  k8s_common_tags    = var.k8s_common_tags
  k8s_region         = data.aws_region.current.name
  k8s_vpc_cidr_block = var.k8s_vpc_cidr_block
}

# ------------------ Subnet ------------------
module "k8s_network_subnet" {
  source                           = "./network/subnet"
  k8s_common_tags                  = var.k8s_common_tags
  k8s_region                       = data.aws_region.current.name
  k8s_vpc_id                       = module.k8s_network_vpc.k8s_vpc_id
  k8s_control_plane_subnets        = var.k8s_control_plane_subnets
  k8s_worker_node_subnets          = var.k8s_worker_node_subnets
  k8s_use_real_private_aws_subnets = var.k8s_use_real_private_aws_subnets
  k8s_nat_subnets                  = var.k8s_nat_subnets
}

# ------------------ Elastic IP ------------------
module "k8s_network_elastic_ip" {
  source          = "./network/elastic_ip"
  k8s_common_tags = var.k8s_common_tags
  k8s_region      = data.aws_region.current.name
  k8s_nat_subnets = var.k8s_nat_subnets
}

# ------------------ Internet Gateway ------------------
module "k8s_network_internet_gateway" {
  source          = "./network/internet_gateway"
  k8s_common_tags = var.k8s_common_tags
  k8s_region      = data.aws_region.current.name
  k8s_vpc_id      = module.k8s_network_vpc.k8s_vpc_id
}

# ------------------ NAT Gateway ------------------
module "k8s_network_nat_gateway" {
  source               = "./network/nat_gateway"
  k8s_common_tags      = var.k8s_common_tags
  k8s_region           = data.aws_region.current.name
  k8s_nat_subnet_id_az = module.k8s_network_subnet.k8s_nat_subnet_id_az
  k8s_nat_eip_az       = module.k8s_network_elastic_ip.k8s_nat_eip_az
}

# ------------------ Route Table ------------------
module "k8s_network_route_table" {
  source                  = "./network/route_table"
  k8s_common_tags         = var.k8s_common_tags
  k8s_region              = data.aws_region.current.name
  k8s_vpc_id              = module.k8s_network_vpc.k8s_vpc_id
  k8s_internet_gateway_id = module.k8s_network_internet_gateway.k8s_internet_gateway_id
  k8s_nat_az              = module.k8s_network_nat_gateway.k8s_nat_az
}

# ------------------ Route Table Association ------------------
module "k8s_network_route_table_association" {
  source                                     = "./network/route_table_association"
  k8s_use_real_private_aws_subnets           = var.k8s_use_real_private_aws_subnets
  k8s_internet_gateway_access_route_table_id = module.k8s_network_route_table.k8s_internet_gateway_access_route_table_id
  k8s_nat_gateway_access_route_table_id      = module.k8s_network_route_table.k8s_nat_gateway_access_route_table_id
  k8s_all_kubernetes_subnet_id               = module.k8s_network_subnet.k8s_all_kubernetes_subnet_id
  k8s_all_public_subnet_id                   = module.k8s_network_subnet.k8s_all_public_subnet_id
  k8s_all_kubernetes_private_subnet_id_az    = module.k8s_network_subnet.k8s_all_kubernetes_private_subnet_id_az
}

# ------------------ Route Table Association ------------------
module "k8s_network_security_group" {
  source                                 = "./network/security_group"
  k8s_common_tags                        = var.k8s_common_tags
  k8s_region                             = data.aws_region.current.name
  k8s_vpc_id                             = module.k8s_network_vpc.k8s_vpc_id
  k8s_all_kubernetes_subnets_cidr_blocks = module.k8s_network_subnet.k8s_all_kubernetes_subnets_cidr_blocks
  k8s_all_subnets_cidr_blocks            = module.k8s_network_subnet.k8s_all_subnets_cidr_blocks
  k8s_control_plane_subnets_cidr_blocks  = module.k8s_network_subnet.k8s_control_plane_subnets_cidr_blocks
  k8s_worker_node_subnets_cidr_blocks    = module.k8s_network_subnet.k8s_worker_node_subnets_cidr_blocks
}

# ------------------ IAM Role ------------------
module "k8s_iam_role" {
  source          = "./iam/role"
  k8s_common_tags = var.k8s_common_tags
  k8s_vpc_id      = module.k8s_network_vpc.k8s_vpc_id
}

# ------------------ IAM Instance Profile ------------------
module "k8s_iam_instance_profile" {
  source           = "./iam/instance_profile"
  k8s_common_tags  = var.k8s_common_tags
  k8s_ec2_ssm_role = module.k8s_iam_role.k8s_ec2_ssm_role
}

# ------------------ EC2 Key pair ------------------
module "k8s_ec2_key_pair" {
  source                              = "./ec2/key_pair"
  k8s_common_tags                     = var.k8s_common_tags
  k8s_region                          = data.aws_region.current.name
  k8s_key_pair_existant_key_pair_name = var.k8s_key_pair_existant_key_pair_name
  k8s_key_pair_public_key_file        = var.k8s_key_pair_public_key_file
}

# ------------------ EC2 Instance ------------------
module "k8s_ec2_instance" {
  source                                       = "./ec2/instance"
  k8s_common_tags                              = var.k8s_common_tags
  k8s_vpc_id                                   = module.k8s_network_vpc.k8s_vpc_id
  k8s_all_kubernetes_subnet_type_to_id         = module.k8s_network_subnet.k8s_all_kubernetes_subnet_type_to_id
  k8s_ec2_instance_ami                         = var.k8s_ec2_instance_ami
  k8s_ec2_ssm_instance_profile_name            = module.k8s_iam_instance_profile.k8s_ec2_ssm_instance_profile_name
  k8s_key_pair_key_name                        = module.k8s_ec2_key_pair.k8s_key_pair_key_name
  k8s_use_real_private_aws_subnets             = var.k8s_use_real_private_aws_subnets
  k8s_control_plane_instances                  = var.k8s_control_plane_instances
  k8s_worker_node_instances                    = var.k8s_worker_node_instances
  k8s_public_control_plane_security_group_ids  = module.k8s_network_security_group.k8s_public_control_plane_security_group_ids
  k8s_private_control_plane_security_group_ids = module.k8s_network_security_group.k8s_private_control_plane_security_group_ids
  k8s_public_worker_node_security_group_ids    = module.k8s_network_security_group.k8s_public_worker_node_security_group_ids
  k8s_private_worker_node_security_group_ids   = module.k8s_network_security_group.k8s_private_worker_node_security_group_ids
}
