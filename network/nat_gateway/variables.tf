# # network/nat_gateway/variables.tf

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

# ------------------ Subnet ------------------
variable "k8s_nat_subnet_id_az" {
  description = "The IDs of all NAT subnets mapped to their availability zone"
  type        = map(string)
}

# ------------------ Elastic IPs ------------------
variable "k8s_nat_eip_az" {
  description = "The IDs & Allocation IDs of all NAT Elastic IP addresses mapped to their NAT availability zone"
  type = map(object({
    allocation_id = string,
    id            = string,
  }))
}
