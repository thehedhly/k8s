# k8s/examples/simple/main.tf

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

  k8s_ec2_instance_ami                = local.k8s_ec2_instance_ami
  k8s_key_pair_existant_key_pair_name = local.k8s_key_pair_existant_key_pair_name # use an existant AWS key pair
  # k8s_key_pair_public_key_file = local.k8s_key_pair_public_key_file # create a new AWS key pair

  k8s_control_plane_instances = local.k8s_control_plane_instances
  k8s_worker_node_instances   = local.k8s_worker_node_instances

}

### VPC
# kubernetes-dev-eu-central-1-vpc
# 10.0.0.0/16

### Subnets
# kubernetes-dev-eu-central-1a-workernode-frontend-public
# 10.0.11.0/24
# eu-central-1a

# kubernetes-dev-eu-central-1a-controlplane-1-private
# 10.0.11.0/24
# eu-central-1a

# kubernetes-dev-eu-central-1a-controlplane-1-public
# 10.0.2.0/24
# eu-central-1a

# kubernetes-dev-eu-central-1a-workernode-backend-private
# 10.0.12.0/24
# eu-central-1a

# kubernetes-dev-eu-central-1a-controlplane-0-public
# 10.0.1.0/24
# eu-central-1a

# kubernetes-dev-eu-central-1b-workernode-backend-private
# 10.0.13.0/24
# eu-central-1b

# kubernetes-dev-eu-central-1b-controlplane-0-private
# 10.0.4.0/24
# eu-central-1b

### EC2 Instances
# kubernetes-dev-private-controlplane-1
# Public-IP: 3.73.0.42
# Private-IP: 10.0.4.140

# kubernetes-dev-private-workernode-2
# Public-IP: 3.72.68.190
# Private-IP: 10.0.13.130

# kubernetes-dev-public-workernode-0
# Public-IP: 18.184.193.105
# Private-IP: 10.0.11.12

# kubernetes-dev-public-controlplane-1
# Public-IP: 3.79.108.109
# Private-IP: 10.0.1.174

# kubernetes-dev-public-controlplane-0
# Public-IP: 18.185.240.119
# Private-IP: 10.0.1.121

# kubernetes-dev-public-controlplane-2
# Public-IP: 3.71.49.62
# Private-IP: 10.0.2.101

# kubernetes-dev-private-workernode-0
# Public-IP: 18.185.88.53
# Private-IP: 10.0.12.119

# kubernetes-dev-private-workernode-1
# Public-IP: 52.57.64.248
# Private-IP: 10.0.12.172 

# kubernetes-dev-private-controlplane-0
# Public-IP: 18.197.16.176
# Private-IP: 10.0.4.45

### Security Groups
# http-dev-eu-central-1-private-sg
# Allow HTTP access from own subnets

# http-dev-eu-central-1-public-sg
# Allow HTTP access from everywhere

# https-dev-eu-central-1-private-sg
# Allow HTTPS access from own subnets

# https-dev-eu-central-1-public-sg
# Allow HTTPS access from everywhere

# kubernetes-api-server-dev-eu-central-1-private-sg
# Allow Kubernetes API server access from own subnets

# kubernetes-api-server-dev-eu-central-1-public-sg
# Allow Kubernetes API server access from everywhere

# kubernetes-etcd-client-dev-eu-central-1-hybrid-sg
# Allow ETCD Client access from own control plane subnets

# kubernetes-etcd-peer-communication-dev-eu-central-1-hybrid-sg
# Allow ETCD Peer Communication access from own control plane subnets

# kubernetes-kube-controller-manager-dev-eu-central-1-hybrid-sg
# Allow Kube Controller Manager access from own control plane subnets	

# kubernetes-kube-scheduler-dev-eu-central-1-hybrid-sg
# Allow Kube Scheduler access from own control plane subnets

# kubernetes-kubelet-api-dev-eu-central-1-private-sg
# Allow Kubelet API access from own subnets

# kubernetes-kubelet-api-dev-eu-central-1-public-sg
# Allow Kubelet API access from everywhere

# kubernetes-node-port-dev-eu-central-1-private-sg
# Allow Node Port access from own subnets	

# kubernetes-node-port-dev-eu-central-1-public-sg
# Allow Node Port access from everywhere

# ssh-dev-eu-central-1-private-sg
# Allow SSH access from own subnets	

# ssh-dev-eu-central-1-public-sg
# Allow SSH access from everywhere
