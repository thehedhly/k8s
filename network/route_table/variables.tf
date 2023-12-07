# network/route_table/variables.tf

# ------------------ Common ------------------
variable "k8s_common_tags" {
  description = "The common AWS Tags to apply on all module's resources"
  type        = map(string)
  default = {
    project = "lab"
    owner   = "senjoux"
    stage   = "dev"
  }
  validation {
    condition     = contains(keys(var.k8s_common_tags), "project") && contains(keys(var.k8s_common_tags), "owner") && contains(keys(var.k8s_common_tags), "stage")
    error_message = "All required keys \"project\" \"owner\" and \"stage\" should be present in the Common AWS Tags"
  }
}

variable "k8s_region" {
  description = "The AWS region for provisioning the Kubernetes cluster"
  type        = string
  validation {
    condition     = can(regex("eu-central-1$", var.k8s_region))
    error_message = "Unsupported AWS Region specified. For testing purpose .. limit to only \"eu-central-1\" Region"
  }
}

# ------------------ VPC ------------------
variable "k8s_vpc_id" {
  description = "The Kubernetes AWS VPC ID"
  type        = string
}

# ------------------ Internet Gateway ------------------
variable "k8s_internet_gateway_id" {
  description = "The Kuberntes VPC's Internet Gateway ID"
  type        = string
}

# ------------------ NAT Gateway ------------------
variable "k8s_nat_az" {
  description = "The IDs & Public IPs of all NAT mapped to their NAT availability zone"
  type = map(object({
    id        = string,
    public_ip = string,
  }))
  default = {}
}
