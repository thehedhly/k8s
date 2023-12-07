# network/security_group/variables.tf

# ------------------ Common -------------------
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

variable "k8s_vpc_id" {
  description = "The Kubernetes AWS VPC ID"
  type        = string
}

variable "k8s_region" {
  description = "The AWS region for provisioning the Kubernetes cluster"
  type        = string
  validation {
    condition     = can(regex("eu-central-1$", var.k8s_region))
    error_message = "Unsupported AWS Region specified. For testing purpose .. limit to only \"eu-central-1\" Region."
  }
}

variable "k8s_all_kubernetes_subnets_cidr_blocks" {
  description = "The IPv4 CIDR blocks of all Kubernetes AWS subnets (excluding the NAT subnets)"
  type        = set(string)
  default     = []
}

variable "k8s_all_subnets_cidr_blocks" {
  description = "The IPv4 CIDR blocks of all AWS subnets (including the NAT subnets)"
  type        = set(string)
  default     = []
}

variable "k8s_control_plane_subnets_cidr_blocks" {
  description = "The IPv4 CIDR blocks of all Kubernetes control plane AWS subnets"
  type        = set(string)
  default     = []
}

variable "k8s_worker_node_subnets_cidr_blocks" {
  description = "The IPv4 CIDR blocks of all Kubernetes worker node AWS subnets"
  type        = set(string)
  default     = []
}

# ------------------ SSH -------------------
variable "k8s_ssh_ingress_public_cidr_blocks" {
  description = "The ingress IPv4 CIDR blocks for public SSH security group"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "k8s_ssh_ingress_private_cidr_blocks" {
  description = "The ingress IPv4 CIDR blocks for private SSH security group"
  type        = list(string)
  default     = []
}

# ------------------ HTTP -------------------
variable "k8s_http_ingress_public_cidr_blocks" {
  description = "The ingress IPv4 CIDR blocks for public HTTP security group"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "k8s_http_ingress_private_cidr_blocks" {
  description = "The ingress IPv4 CIDR blocks for private HTTP security group"
  type        = list(string)
  default     = []
}

# ------------------ HTTPS -------------------
variable "k8s_https_ingress_public_cidr_blocks" {
  description = "The ingress IPv4 CIDR blocks for public HTTPS security group"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
variable "k8s_https_ingress_private_cidr_blocks" {
  description = "The ingress IPv4 CIDR blocks for private HTTPS security group"
  type        = list(string)
  default     = []
}

# ------------------ Kubernetes -------------------
# https://kubernetes.io/docs/reference/networking/ports-and-protocols/
# ------------------ Kubernetes API server ------------------
variable "k8s_kubernetes_api_server_port" {
  description = "The Kubernetes API server port number"
  type        = number
  default     = 6443
}

# ------------------ Kubelet API ------------------
variable "k8s_kubelet_api_port" {
  description = "The Kubelet API port number"
  type        = number
  default     = 10250
}

# ------------------ Kube Scheduler ------------------
variable "k8s_kube_scheduler_port" {
  description = "The Kube Scheduler port number"
  type        = number
  default     = 10259
}

# ------------------ Kube Controller Manager ------------------
variable "k8s_kube_controller_manager_port" {
  description = "The Kube Controller Manager port number"
  type        = number
  default     = 10257
}

# ------------------ ETCD Client ------------------
variable "k8s_etcd_client_port" {
  description = "The ETCD Client port number"
  type        = number
  default     = 2379
}

# ------------------ ETCD Peer Communication ------------------
variable "k8s_etcd_peer_communication_port" {
  description = "The ETCD Peer Communication port number"
  type        = number
  default     = 2380
}

# ------------------ NodePort Services ------------------
variable "k8s_node_port_services_port_from" {
  description = "The NodePort Services ports"
  type        = number
  default     = 30000
}

variable "k8s_node_port_services_port_to" {
  description = "The NodePort Services ports"
  type        = number
  default     = 32767
}
