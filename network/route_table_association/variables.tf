# network/route_table_association/variables.tf

# # ------------------ Route Table ------------------
variable "k8s_internet_gateway_access_route_table_id" {
  description = "The ID of AWS Route Table used for accessing the internet from the Kubernetes AWS Subnets"
  type        = string
}

variable "k8s_nat_gateway_access_route_table_id" {
  description = "The ID of AWS Route Table used for accessing NAT Gateway from the Kubernetes AWS Subnets"
  type        = map(string)
}

# ------------------ Subnets ------------------
variable "k8s_all_kubernetes_subnet_id" {
  description = "The IDs of all Kubernetes cluster subnets (excluding the NAT subnets)"
  type        = list(string)
}

variable "k8s_all_public_subnet_id" {
  description = "The IDs of all public subnets (including the NAT subnets)"
  type        = list(string)
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

variable "k8s_all_kubernetes_private_subnet_id_az" {
  description = "The IDs of all private Kubernetes subnets mapped to their availability zoness"
  type = list(object({
    id = string,
    az = string,
  }))
  default = []
}
