# iam/instance_profile/outputs.tf

# ------------------ Instance Profile ------------------
output "k8s_ec2_ssm_instance_profile_name" {
  value       = aws_iam_instance_profile.k8s_ec2_ssm.name
  description = "The name of the SSM AWS Instance profile"
}
