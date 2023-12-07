# ec2/key_pair/variables.tf

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

# ------------------ Key pair ------------------
variable "k8s_key_pair_existant_key_pair_name" {
  description = "The existant AWS key pair name. If no existant key pair name if provided, a new AWS key pair will be created. The AWS key pair will be provided to the Kubernetes AWS EC2 instance(s) on provisioing"
  type        = string
  default     = null
}
variable "k8s_key_pair_public_key_file" {
  description = "The SSH public key file for creating the new AWS key pair. The key will be used for SSH accessing the Kubernetes AWS EC2 instance(s)"
  type        = string
  default     = null
}
