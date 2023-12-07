# k8s/examples/advanced/main.tf

locals {
  # ------------------ Common ------------------
  k8s_region = "eu-central-1"
  # k8s_profile = "default"

  k8s_common_tags = {
    project = "k8s_lab"
    owner   = "hamza"
    stage   = "dev"
  }

  # ------------------ VPC ------------------
  k8s_vpc_cidr_block = "10.0.0.0/16"

  # ------------------ Subnets ------------------

  k8s_use_real_private_aws_subnets = true

  k8s_nat_subnets = { "a" = "10.0.10.0/24", "b" = "10.0.20.0/24" }

  k8s_control_plane_subnets = [
    {
      cidr_block        = "10.0.1.0/24",
      availability_zone = "a",
      type              = "public",
      usage_extra       = "0", # can use "0", "foo", "bar" .. or whatever plain string
    },
    {
      cidr_block        = "10.0.2.0/24",
      availability_zone = "a",
      type              = "public",
      usage_extra       = "1", # can use "0", "foo", "bar" .. or whatever plain string
    },
    {
      cidr_block        = "10.0.3.0/24",
      availability_zone = "a",
      type              = "private",
      usage_extra       = "1", # can use "0", "foo", "bar" .. or whatever plain string
    },
    {
      cidr_block        = "10.0.4.0/24",
      availability_zone = "b",
      type              = "private",
      usage_extra       = "0",
    },
  ]

  k8s_worker_node_subnets = [
    {
      cidr_block        = "10.0.11.0/24",
      availability_zone = "a",
      type              = "public",
      usage_extra       = "frontend",
    },
    {
      cidr_block        = "10.0.12.0/24",
      availability_zone = "a",
      type              = "private"
      usage_extra       = "backend",
    },
    {
      cidr_block        = "10.0.13.0/24",
      availability_zone = "b",
      type              = "private",
      usage_extra       = "backend",
    },
  ]
  # ------------------ EC2 Instance ------------------
  k8s_key_pair_existant_key_pair_name = "k8s" # to use an existant AWS key pair
  # k8s_key_pair_public_key_file = "/path/to/mykey.pub" # to create a new AWS key pair

  # ------------------ EC2 Instance ------------------

  k8s_ec2_instance_ami = "ami-084872984773e3cde" # Ubuntu Kinetic Kudu in eu-central-1

  k8s_control_plane_instances = [
    # 2 public control planes within the public subnet of usage "0" in the eu-central-1a availability zone
    {
      instance_type       = "t2.micro",
      type                = "public",
      subnet_usage_filter = "0",
      # az_filter           = "a" # default to "a"
    },
    {
      instance_type       = "t2.micro",
      type                = "public",
      subnet_usage_filter = "0",
      # az_filter           = "a" # default to "a"
    },
    # 1 private control plane within the private subnet of usage "0" in the eu-central-1a availability zone
    {
      instance_type       = "t2.micro",
      type                = "public",
      subnet_usage_filter = "1",
      # az_filter           = "a" # default to "a"
    },
    # 2 private control planes within the private subnet of usage "0" in the eu-central-1b availability zone
    {
      instance_type       = "t2.micro",
      type                = "private",
      subnet_usage_filter = "0",
      az_filter           = "b"
    },
    {
      instance_type       = "t2.micro",
      type                = "private",
      subnet_usage_filter = "0",
      az_filter           = "b"
    },
  ]

  k8s_worker_node_instances = [
    # 1 public worker node (could be used for frondend Pods) within the public subnet of usage "frontend" in the eu-central-1a availability zone
    {
      instance_type       = "t2.micro",
      type                = "public",
      subnet_usage_filter = "frontend",
      # az_filter           = "a" # default to "a"
    },
    # 2 private worker nodes (could be used for backend Pods) within the private subnet of usage "backend" in the eu-central-1a availability zone
    {
      instance_type       = "t2.micro",
      type                = "private",
      subnet_usage_filter = "backend",
      # az_filter           = "a" # default to "a"
    },
    {
      instance_type       = "t2.micro",
      type                = "private",
      subnet_usage_filter = "backend",
      # az_filter           = "a" # default to "a"
    },
    # 1 private worker nodes (could be used for backend Pods) within the private subnet of usage "backend" in the eu-central-1b availability zone
    {
      instance_type       = "t2.micro",
      type                = "private",
      subnet_usage_filter = "backend",
      az_filter           = "b"
    },
  ]

}

# ------------------ k8s module ------------------
module "k8s" {
  source = "../../"

  k8s_region = local.k8s_region
  #k8s_profile = local.k8s_profile

  k8s_common_tags = local.k8s_common_tags

  k8s_vpc_cidr_block = local.k8s_vpc_cidr_block

  k8s_control_plane_subnets = local.k8s_control_plane_subnets
  k8s_worker_node_subnets   = local.k8s_worker_node_subnets

  k8s_use_real_private_aws_subnets = local.k8s_use_real_private_aws_subnets
  k8s_nat_subnets                  = local.k8s_nat_subnets

  k8s_ec2_instance_ami                = local.k8s_ec2_instance_ami
  k8s_key_pair_existant_key_pair_name = local.k8s_key_pair_existant_key_pair_name # to use an existant AWS key pair
  # k8s_key_pair_public_key_file = local.k8s_key_pair_public_key_file # to create a new AWS key pair

  k8s_control_plane_instances = local.k8s_control_plane_instances
  k8s_worker_node_instances   = local.k8s_worker_node_instances

}
