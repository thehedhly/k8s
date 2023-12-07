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

# ------------------ NAT Subnets ------------------
variable "k8s_nat_subnets" {
  description = <<-EOF
              The list of AWS NAT subnets objects. 
              The NAT Subnets are all public AWS Subnets.
              The NAT Subnets will be created only if "k8s_use_real_private_aws_subnets" is set to "true".
              EOF
  type        = map(string)
  validation {
    condition = alltrue([
      for key, value in var.k8s_nat_subnets : contains(["a", "b", "c"], key)
    ])
    error_message = "Allowed values for availability_zone are [\"a\", \"b\", \"c\"]"
  }
  default = {}
}
