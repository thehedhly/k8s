# network/security_group/outputs.tf

# ------------------ Common ------------------
# ------------------ SSH ------------------
output "k8s_public_ssh_security_group_id" {
  description = "The ID of public SSH AWS security group"
  value       = aws_security_group.k8s_public_ssh.id
}

output "k8s_private_ssh_security_group_id" {
  description = "The ID of private SSH AWS security group"
  value       = aws_security_group.k8s_private_ssh.id
}

# ------------------ HTTP ------------------
output "k8s_public_http_security_group_id" {
  description = "The ID of public HTTP AWS security group"
  value       = aws_security_group.k8s_public_http.id
}

output "k8s_private_http_security_group_id" {
  description = "The ID of private HTTP AWS security group"
  value       = aws_security_group.k8s_private_http.id
}

# ------------------ HTTPS ------------------
output "k8s_public_https_security_group_id" {
  description = "The ID of public HTTPS AWS security group"
  value       = aws_security_group.k8s_public_https.id
}

output "k8s_private_https_security_group_id" {
  description = "The ID of private HTTPS AWS security group"
  value       = aws_security_group.k8s_private_https.id
}

# ------------------ Kubernetes ------------------
# ------------------ Kubernetes API server ------------------
output "k8s_public_kubernetes_api_server_security_group_id" {
  description = "The ID of the public Kubernetes API server AWS security group"
  value       = aws_security_group.k8s_public_kubernetes_api_server.id
}

output "k8s_private_kubernetes_api_server_security_group_id" {
  description = "The ID of the private the Kubernetes API server AWS security group"
  value       = aws_security_group.k8s_private_kubernetes_api_server.id
}

# ------------------ Kubelet API ------------------
output "k8s_public_kubelet_api_security_group_id" {
  description = "The ID of the public Kubelet API AWS security group"
  value       = aws_security_group.k8s_public_kubelet_api.id
}

output "k8s_private_kubelet_api_security_group_id" {
  description = "The ID of the private Kubelet API security group"
  value       = aws_security_group.k8s_private_kubelet_api.id
}

# ------------------ Kube Scheduler ------------------
output "k8s_kube_scheduler_security_group_id" {
  description = "The ID of the Kube Scheduler AWS security group"
  value       = aws_security_group.k8s_kube_scheduler.id
}

# ------------------ Kube Controller Manager ------------------
output "k8s_kube_controller_manager_security_group_id" {
  description = "The ID of the Kube Controller Manager AWS security group"
  value       = aws_security_group.k8s_kube_controller_manager.id
}

# ------------------ ETCD Client ------------------
output "k8s_etcd_client_security_group_id" {
  description = "The ID of the ETCD Client AWS security group"
  value       = aws_security_group.k8s_etcd_client.id
}

# ------------------ ETCD Peer Communication ------------------
output "k8s_public_node_port_services_security_group_id" {
  description = "The ID of the public Node Port services AWS security group"
  value       = aws_security_group.k8s_etcd_peer_communication.id
}

# ------------------ NodePort Services ------------------
output "k8s_private_node_port_services_security_group_id" {
  description = "The ID of the private Node Port services AWS security group"
  value       = aws_security_group.k8s_private_node_port_services.id
}

output "k8s_public_control_plane_security_group_ids" {
  description = "The IDs of all AWS security groups to be used by public Kubernetes control planes"
  value = [aws_security_group.k8s_public_ssh.id, aws_security_group.k8s_public_http.id,
    aws_security_group.k8s_public_https.id, aws_security_group.k8s_public_kubernetes_api_server.id,
    aws_security_group.k8s_public_kubelet_api.id, aws_security_group.k8s_kube_scheduler.id,
    aws_security_group.k8s_kube_controller_manager.id, aws_security_group.k8s_etcd_client.id,
    aws_security_group.k8s_etcd_peer_communication.id
  ]
}

output "k8s_private_control_plane_security_group_ids" {
  description = "The IDs of all AWS security groups to be used by private Kubernetes control planes"
  value = [aws_security_group.k8s_private_ssh.id, aws_security_group.k8s_private_http.id, aws_security_group.k8s_private_https.id,
    aws_security_group.k8s_private_kubernetes_api_server.id, aws_security_group.k8s_private_kubelet_api.id,
    aws_security_group.k8s_kube_scheduler.id, aws_security_group.k8s_kube_controller_manager.id,
    aws_security_group.k8s_etcd_client.id, aws_security_group.k8s_etcd_peer_communication.id
  ]
}

output "k8s_public_worker_node_security_group_ids" {
  description = "The IDs of all AWS security groups to be used by public Kubernetes worker nodes"
  value = [aws_security_group.k8s_public_ssh.id, aws_security_group.k8s_public_http.id,
    aws_security_group.k8s_public_https.id, aws_security_group.k8s_public_kubelet_api.id
  ]
}

output "k8s_private_worker_node_security_group_ids" {
  description = "The IDs of all AWS security groups to be used by private Kubernetes worker nodes"
  value = [aws_security_group.k8s_private_ssh.id, aws_security_group.k8s_private_http.id, aws_security_group.k8s_private_https.id,
    aws_security_group.k8s_private_kubelet_api.id
  ]
}
