# network/subnet/variables.tf

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

# ------------------ Subnets ------------------
variable "k8s_control_plane_subnets" {
  description = <<-EOF
              The list of Kubernetes control plane AWS subnets objects. Subnets can have either public or private.
              Public control planes have both Ingress & Egress Internet traffic. Private control planes have only Egress Internet traffic.
              Private control plane subnets can be:
                - (per default) provisioned as public AWS subnets with blocked Ingress internet traffic on EC2 Instance Security Groups level, however Egress Internet access is allowed.
                - provisioned as real private AWS subnets (blocked Ingress internet traffic on subnet level). Egress Internet access follows through a NAT Gateway (extra costs apply)
              See also "k8s_use_real_private_aws_subnets" Variable.
              EOF
  type = list(object({
    cidr_block        = string,
    availability_zone = string,
    type              = string,
    usage_extra       = string,
  }))
  validation {
    condition = alltrue([
      for subnet in var.k8s_control_plane_subnets : contains(["a", "b", "c"], subnet.availability_zone) && contains(["public", "private"], subnet.type)
    ])
    error_message = "Allowed values for availability_zone are [\"a\", \"b\", \"c\"]\nAllowed values for type are [\"public\",\"private\"]"
  }
}

variable "k8s_worker_node_subnets" {
  description = <<-EOF
              The list of Kubernetes worker node AWS subnets objects. Subnets can have either public or private.
              Public worker nodes have both Ingress & Egress Internet traffic. Private worker nodes have only Egress Internet traffic.
              Private worker node subnets can be:
                - (per default) provisioned as public AWS subnets with blocked Ingress internet traffic on EC2 Instance Security Groups level, however Egress Internet access is allowed.
                - provisioned as real private AWS subnets (blocked Ingress internet traffic on subnet level). Egress Internet access follows through a NAT Gateway (extra costs apply)
              See also "k8s_use_real_private_aws_subnets" Variable.
              EOF
  type = list(object({
    cidr_block        = string,
    availability_zone = string,
    type              = string,
    usage_extra       = string,
  }))
  validation {
    condition = alltrue([
      for subnet in var.k8s_worker_node_subnets : contains(["a", "b", "c"], subnet.availability_zone) && contains(["public", "private"], subnet.type)
    ])
    error_message = "Allowed values for availability_zone are [\"a\", \"b\", \"c\"]\nAllowed values for type are [\"public\", \"private\"]"
  }
}

variable "k8s_use_real_private_aws_subnets" {
  description = <<-EOF
                Control what type of subnets to use for private control planes & private worker nodes subnets."
                Private subnets can be:
                  - (per default) provisioned as public AWS subnets with blocked Ingress internet traffic on EC2 Instance Security Groups level, however Egress Internet access is allowed.
                  - provisioned as real private AWS subnets (blocked Ingress internet traffic on subnet level). Egress Internet access follows through a NAT Gateway (extra costs apply)
                EOF
  type        = bool
  default     = false
}

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
