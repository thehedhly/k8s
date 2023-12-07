# iam/instance_profile/resources.tf

# ------------------ Instance Profile ------------------
resource "aws_iam_instance_profile" "k8s_ec2_ssm" {
  name = "kubernetes-ec2-ssm-${var.k8s_common_tags.stage}"
  role = var.k8s_ec2_ssm_role
  tags = merge({ "Name" = "kubernetes-ec2-ssm-${var.k8s_common_tags.stage}" }, var.k8s_common_tags)
}
