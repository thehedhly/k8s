# iam/role/outputs.tf

output "k8s_ec2_ssm_role" {
  value       = aws_iam_role.k8s_ec2_ssm.name
  description = "The AWS Role name for setting up the SSM AWS Instance-Profile"
}
