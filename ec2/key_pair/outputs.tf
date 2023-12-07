# ec2/key_pair/outputs.tf

output "k8s_key_pair_key_name" {
  description = "The AWS key pair which will be provided to the Kubernetes AWS EC2 instance(s) on provisioing"
  value       = var.k8s_key_pair_existant_key_pair_name == null ? aws_key_pair.k8s[0].key_name : var.k8s_key_pair_existant_key_pair_name
}
