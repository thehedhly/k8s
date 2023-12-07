# ec2/instance/variables.tf

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

# ------------------ VPC ------------------
variable "k8s_vpc_id" {
  description = "The Kubernetes AWS VPC ID"
  type        = string
}

# ------------------ Subnet ------------------
variable "k8s_all_kubernetes_subnet_type_to_id" {
  description = "Subnet mapping in the form of \"[subnet type: public/private]@[subnet usage: control_plane/worker_node]@[Availability zone: a/b/c]@[subnet usage extra: *]\" to \"[subnet ID]\""
  type        = map(string)
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

# ------------------ IAM Security Group ------------------
variable "k8s_public_control_plane_security_group_ids" {
  description = "The IDs of all AWS security groups to be used by public Kubernetes control planes"
  type        = set(string)
}
variable "k8s_private_control_plane_security_group_ids" {
  description = "The IDs of all AWS security groups to be used by private Kubernetes control planes"
  type        = set(string)
}
variable "k8s_public_worker_node_security_group_ids" {
  description = "The IDs of all AWS security groups to be used by public Kubernetes worker nodes"
  type        = set(string)
}
variable "k8s_private_worker_node_security_group_ids" {
  description = "The IDs of all AWS security groups to be used by private Kubernetes worker nodes"
  type        = set(string)
}

# ------------------ IAM Instance Profile ------------------
variable "k8s_ec2_ssm_instance_profile_name" {
  description = "The name of the SSM AWS Instance profile"
  type        = string
}

# ------------------ EC2 Key pair ------------------
variable "k8s_key_pair_key_name" {
  description = "The AWS key pair which will be provided to the Kubernetes AWS EC2 instance(s) on provisioing"
  type        = string
}

# ------------------ EC2 Instance ------------------
variable "k8s_ec2_instance_ami" {
  description = "The AWS AMI to be used for AWS EC2 instance(s) creation"
  type        = string
}

variable "k8s_control_plane_instances" {
  description = "The list of Kubernetes control plane AWS EC2 instance(s) objects"
  type = list(object({
    instance_type       = string,
    type                = string,
    subnet_usage_filter = string,
    az_filter           = optional(string, "a"),
  }))
}

variable "k8s_worker_node_instances" {
  description = "The list of Kubernetes worker node AWS EC2 instance(s) objects"
  type = list(object({
    instance_type       = string,
    type                = string,
    subnet_usage_filter = string,
    az_filter           = optional(string, "a"),
  }))
}
