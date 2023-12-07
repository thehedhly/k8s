# ec2/key_pair/resources.tf

resource "aws_key_pair" "k8s" {
  count      = var.k8s_key_pair_existant_key_pair_name == null ? 1 : 0
  key_name   = "kubernetes-${var.k8s_region}-${var.k8s_common_tags.stage}"
  public_key = file(var.k8s_key_pair_public_key_file)

  # Name: {firstname}.{lastname}-{group}-{env}-[{scope}]
  tags = merge(tomap({ "Name" = "kubernetes.ubuntu-${var.k8s_region}-${var.k8s_common_tags.stage}" }), var.k8s_common_tags)
}
