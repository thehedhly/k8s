# iam/role/resources.tf

# ------------------ Policy Document ------------------
data "aws_iam_policy_document" "ec2_instance_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:EC2InstanceSourceVPC"
      values = [
        var.k8s_vpc_id,
      ]
    }
  }
}

# ------------------ Policy ------------------
data "aws_iam_policy" "ssm_managed_instance_core" {
  name = "AmazonSSMManagedInstanceCore"
}

# ------------------ Role ------------------
resource "aws_iam_role" "k8s_ec2_ssm" {
  # Name: kubernetes-ec2-ssm-EnvironmentCode
  name                = "kubernetes-ec2-ssm-${var.k8s_common_tags.stage}"
  assume_role_policy  = data.aws_iam_policy_document.ec2_instance_assume_role.json
  managed_policy_arns = [data.aws_iam_policy.ssm_managed_instance_core.arn]
  tags                = merge({ "Name" = "kubernetes-ec2-ssm-${var.k8s_common_tags.stage}" }, var.k8s_common_tags)
}
