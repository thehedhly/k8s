# network/security_group/resources.tf

# ------------------ Common -------------------
# ------------------ SSH ------------------
resource "aws_security_group" "k8s_public_ssh" {
  vpc_id = var.k8s_vpc_id
  # Name: {group}-{env}-[{region}]-[{scope}]-sg
  tags        = merge(tomap({ "Name" = "ssh-${var.k8s_common_tags.stage}-${var.k8s_region}-public-sg", "usage" = "common", "type" = "public" }), var.k8s_common_tags)
  description = "Allow SSH access from everywhere"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.k8s_ssh_ingress_public_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "k8s_private_ssh" {
  vpc_id = var.k8s_vpc_id
  # Name: {group}-{env}-[{region}]-[{scope}]-sg
  tags        = merge(tomap({ "Name" = "ssh-${var.k8s_common_tags.stage}-${var.k8s_region}-private-sg", "usage" = "common", "type" = "private" }), var.k8s_common_tags)
  description = "Allow SSH access from own subnets"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.k8s_all_subnets_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------ HTTP ------------------
resource "aws_security_group" "k8s_public_http" {
  vpc_id = var.k8s_vpc_id
  # Name: {group}-{env}-[{region}]-[{scope}]-sg
  tags        = merge(tomap({ "Name" = "http-${var.k8s_common_tags.stage}-${var.k8s_region}-public-sg", "usage" = "common", "type" = "public" }), var.k8s_common_tags)
  description = "Allow HTTP access from everywhere"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.k8s_http_ingress_public_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "k8s_private_http" {
  vpc_id = var.k8s_vpc_id
  # Name: {group}-{env}-[{region}]-[{scope}]-sg
  tags        = merge(tomap({ "Name" = "http-${var.k8s_common_tags.stage}-${var.k8s_region}-private-sg", "usage" = "common", "type" = "private" }), var.k8s_common_tags)
  description = "Allow HTTP access from own subnets"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.k8s_all_subnets_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------ HTTPS ------------------
resource "aws_security_group" "k8s_public_https" {
  vpc_id = var.k8s_vpc_id
  # Name: {group}-{env}-[{region}]-[{scope}]-sg
  tags        = merge(tomap({ "Name" = "https-${var.k8s_common_tags.stage}-${var.k8s_region}-public-sg", "usage" = "common", "type" = "public" }), var.k8s_common_tags)
  description = "Allow HTTPS access from everywhere"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.k8s_https_ingress_public_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "k8s_private_https" {
  vpc_id = var.k8s_vpc_id
  # Name: {group}-{env}-[{region}]-[{scope}]-sg
  tags        = merge(tomap({ "Name" = "https-${var.k8s_common_tags.stage}-${var.k8s_region}-private-sg", "usage" = "common", "type" = "private" }), var.k8s_common_tags)
  description = "Allow HTTPS access from own subnets"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.k8s_all_subnets_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------ Kubernetes ------------------
# ------------------ Kubernetes API server ------------------
resource "aws_security_group" "k8s_public_kubernetes_api_server" {
  vpc_id = var.k8s_vpc_id
  # Name: {group}-{env}-[{region}]-[{scope}]-sg
  tags        = merge(tomap({ "Name" = "kubernetes-api-server-${var.k8s_common_tags.stage}-${var.k8s_region}-public-sg", "usage" = "control_plane", "type" = "public" }), var.k8s_common_tags)
  description = "Allow Kubernetes API server access from everywhere"

  ingress {
    from_port   = var.k8s_kubernetes_api_server_port
    to_port     = var.k8s_kubernetes_api_server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "k8s_private_kubernetes_api_server" {
  vpc_id = var.k8s_vpc_id
  # Name: {group}-{env}-[{region}]-[{scope}]-sg
  tags        = merge(tomap({ "Name" = "kubernetes-api-server-${var.k8s_common_tags.stage}-${var.k8s_region}-private-sg", "usage" = "control_plane", "type" = "private" }), var.k8s_common_tags)
  description = "Allow Kubernetes API server access from own subnets"

  ingress {
    from_port   = var.k8s_kubernetes_api_server_port
    to_port     = var.k8s_kubernetes_api_server_port
    protocol    = "tcp"
    cidr_blocks = var.k8s_all_subnets_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------ Kubelet API ------------------
resource "aws_security_group" "k8s_public_kubelet_api" {
  vpc_id = var.k8s_vpc_id
  # Name: {group}-{env}-[{region}]-[{scope}]-sg
  tags        = merge(tomap({ "Name" = "kubernetes-kubelet-api-${var.k8s_common_tags.stage}-${var.k8s_region}-public-sg", "usage" = "common", "type" = "public" }), var.k8s_common_tags)
  description = "Allow Kubelet API access from everywhere"

  ingress {
    from_port   = var.k8s_kubelet_api_port
    to_port     = var.k8s_kubelet_api_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "k8s_private_kubelet_api" {
  vpc_id = var.k8s_vpc_id
  # Name: {group}-{env}-[{region}]-[{scope}]-sg
  tags        = merge(tomap({ "Name" = "kubernetes-kubelet-api-${var.k8s_common_tags.stage}-${var.k8s_region}-private-sg", "usage" = "common", "type" = "private" }), var.k8s_common_tags)
  description = "Allow Kubelet API access from own subnets"

  ingress {
    from_port   = var.k8s_kubelet_api_port
    to_port     = var.k8s_kubelet_api_port
    protocol    = "tcp"
    cidr_blocks = var.k8s_all_subnets_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------ Kube Scheduler ------------------
resource "aws_security_group" "k8s_kube_scheduler" {
  vpc_id = var.k8s_vpc_id
  # Name: {group}-{env}-[{region}]-[{scope}]-sg
  tags        = merge(tomap({ "Name" = "kubernetes-kube-scheduler-${var.k8s_common_tags.stage}-${var.k8s_region}-hybrid-sg", "usage" = "control_plane", "type" = "hybrid" }), var.k8s_common_tags)
  description = "Allow Kube Scheduler access from own control plane subnets"

  ingress {
    from_port   = var.k8s_kube_scheduler_port
    to_port     = var.k8s_kube_scheduler_port
    protocol    = "tcp"
    cidr_blocks = var.k8s_control_plane_subnets_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------ Kube Controller Manager ------------------
resource "aws_security_group" "k8s_kube_controller_manager" {
  vpc_id = var.k8s_vpc_id
  # Name: {group}-{env}-[{region}]-[{scope}]-sg
  tags        = merge(tomap({ "Name" = "kubernetes-kube-controller-manager-${var.k8s_common_tags.stage}-${var.k8s_region}-hybrid-sg", "usage" = "control_plane", "type" = "hybrid" }), var.k8s_common_tags)
  description = "Allow Kube Controller Manager access from own control plane subnets"

  ingress {
    from_port   = var.k8s_kube_controller_manager_port
    to_port     = var.k8s_kube_controller_manager_port
    protocol    = "tcp"
    cidr_blocks = var.k8s_control_plane_subnets_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------ ETCD Client ------------------
resource "aws_security_group" "k8s_etcd_client" {
  vpc_id = var.k8s_vpc_id
  # Name: {group}-{env}-[{region}]-[{scope}]-sg
  tags        = merge(tomap({ "Name" = "kubernetes-etcd-client-${var.k8s_common_tags.stage}-${var.k8s_region}-hybrid-sg", "usage" = "control_plane", "type" = "hybrid" }), var.k8s_common_tags)
  description = "Allow ETCD Client access from own control plane subnets"

  ingress {
    from_port   = var.k8s_etcd_client_port
    to_port     = var.k8s_etcd_client_port
    protocol    = "tcp"
    cidr_blocks = var.k8s_control_plane_subnets_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------ ETCD Peer Communication ------------------
resource "aws_security_group" "k8s_etcd_peer_communication" {
  vpc_id = var.k8s_vpc_id
  # Name: {group}-{env}-[{region}]-[{scope}]-sg
  tags        = merge(tomap({ "Name" = "kubernetes-etcd-peer-communication-${var.k8s_common_tags.stage}-${var.k8s_region}-hybrid-sg", "usage" = "control_plane", "type" = "hybrid" }), var.k8s_common_tags)
  description = "Allow ETCD Peer Communication access from own control plane subnets"

  ingress {
    from_port   = var.k8s_etcd_peer_communication_port
    to_port     = var.k8s_etcd_peer_communication_port
    protocol    = "tcp"
    cidr_blocks = var.k8s_control_plane_subnets_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------ NodePort Services ------------------
resource "aws_security_group" "k8s_public_node_port_services" {
  vpc_id = var.k8s_vpc_id
  # Name: {group}-{env}-[{region}]-[{scope}]-sg
  tags        = merge(tomap({ "Name" = "kubernetes-node-port-${var.k8s_common_tags.stage}-${var.k8s_region}-public-sg", "usage" = "worker_node", "type" = "public" }), var.k8s_common_tags)
  description = "Allow Node Port access from everywhere"

  ingress {
    from_port   = var.k8s_node_port_services_port_from
    to_port     = var.k8s_node_port_services_port_to
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "k8s_private_node_port_services" {
  vpc_id = var.k8s_vpc_id
  # Name: {group}-{env}-[{region}]-[{scope}]-sg
  tags        = merge(tomap({ "Name" = "kubernetes-node-port-${var.k8s_common_tags.stage}-${var.k8s_region}-private-sg", "usage" = "worker_node", "type" = "private" }), var.k8s_common_tags)
  description = "Allow Node Port access from own subnets"

  ingress {
    from_port   = var.k8s_node_port_services_port_from
    to_port     = var.k8s_node_port_services_port_to
    protocol    = "tcp"
    cidr_blocks = var.k8s_all_subnets_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
