<!-- BEGIN_TF_DOCS -->

# k8s/subnnet

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.15.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.15.0 |
## Modules

No modules.
## Resources

| Name | Type |
|------|------|
| [aws_subnet.k8s_control_plane_private](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/subnet) | resource |
| [aws_subnet.k8s_control_plane_public](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/subnet) | resource |
| [aws_subnet.k8s_nat](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/subnet) | resource |
| [aws_subnet.k8s_worker_node_private](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/subnet) | resource |
| [aws_subnet.k8s_worker_node_public](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/subnet) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k8s_common_tags"></a> [k8s\_common\_tags](#input\_k8s\_common\_tags) | The common AWS Tags to apply on all module's resources | `map(string)` | <pre>{<br>  "owner": "senjoux",<br>  "project": "lab",<br>  "stage": "dev"<br>}</pre> | no |
| <a name="input_k8s_region"></a> [k8s\_region](#input\_k8s\_region) | The AWS region for provisioning the Kubernetes cluster | `string` | n/a | yes |
| <a name="input_k8s_vpc_id"></a> [k8s\_vpc\_id](#input\_k8s\_vpc\_id) | The Kubernetes AWS VPC ID | `string` | n/a | yes |
| <a name="input_k8s_control_plane_subnets"></a> [k8s\_control\_plane\_subnets](#input\_k8s\_control\_plane\_subnets) | The list of Kubernetes control plane AWS subnets objects. Subnets can have either public or private.<br>Public control planes have both Ingress & Egress Internet traffic. Private control planes have only Egress Internet traffic.<br>Private control plane subnets can be:<br>  - (per default) provisioned as public AWS subnets with blocked Ingress internet traffic on EC2 Instance Security Groups level, however Egress Internet access is allowed.<br>  - provisioned as real private AWS subnets (blocked Ingress internet traffic on subnet level). Egress Internet access follows through a NAT Gateway (extra costs apply)<br>See also "k8s\_use\_real\_private\_aws\_subnets" Variable. | <pre>list(object({<br>    cidr_block        = string,<br>    availability_zone = string,<br>    type              = string,<br>    usage_extra       = string,<br>  }))</pre> | n/a | yes |
| <a name="input_k8s_worker_node_subnets"></a> [k8s\_worker\_node\_subnets](#input\_k8s\_worker\_node\_subnets) | The list of Kubernetes worker node AWS subnets objects. Subnets can have either public or private.<br>Public worker nodes have both Ingress & Egress Internet traffic. Private worker nodes have only Egress Internet traffic.<br>Private worker node subnets can be:<br>  - (per default) provisioned as public AWS subnets with blocked Ingress internet traffic on EC2 Instance Security Groups level, however Egress Internet access is allowed.<br>  - provisioned as real private AWS subnets (blocked Ingress internet traffic on subnet level). Egress Internet access follows through a NAT Gateway (extra costs apply)<br>See also "k8s\_use\_real\_private\_aws\_subnets" Variable. | <pre>list(object({<br>    cidr_block        = string,<br>    availability_zone = string,<br>    type              = string,<br>    usage_extra       = string,<br>  }))</pre> | n/a | yes |
| <a name="input_k8s_use_real_private_aws_subnets"></a> [k8s\_use\_real\_private\_aws\_subnets](#input\_k8s\_use\_real\_private\_aws\_subnets) | Control what type of subnets to use for private control planes & private worker nodes subnets."<br>Private subnets can be:<br>  - (per default) provisioned as public AWS subnets with blocked Ingress internet traffic on EC2 Instance Security Groups level, however Egress Internet access is allowed.<br>  - provisioned as real private AWS subnets (blocked Ingress internet traffic on subnet level). Egress Internet access follows through a NAT Gateway (extra costs apply) | `bool` | `false` | no |
| <a name="input_k8s_nat_subnets"></a> [k8s\_nat\_subnets](#input\_k8s\_nat\_subnets) | The list of AWS NAT subnets objects. <br>The NAT Subnets are all public AWS Subnets.<br>The NAT Subnets will be created only if "k8s\_use\_real\_private\_aws\_subnets" is set to "true". | `map(string)` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_control_plane_public_subnet_id"></a> [k8s\_control\_plane\_public\_subnet\_id](#output\_k8s\_control\_plane\_public\_subnet\_id) | The IDs of all public Kubernetes control plane subnets |
| <a name="output_k8s_control_plane_private_subnet_id"></a> [k8s\_control\_plane\_private\_subnet\_id](#output\_k8s\_control\_plane\_private\_subnet\_id) | The IDs of all private Kubernetes control plane subnets |
| <a name="output_k8s_worker_node_public_subnet_id"></a> [k8s\_worker\_node\_public\_subnet\_id](#output\_k8s\_worker\_node\_public\_subnet\_id) | The IDs of all public Worker node subnets |
| <a name="output_k8s_worker_node_private_subnet_id"></a> [k8s\_worker\_node\_private\_subnet\_id](#output\_k8s\_worker\_node\_private\_subnet\_id) | The IDs of all private Kubernetes worker node subnets |
| <a name="output_k8s_control_plane_subnets_cidr_blocks"></a> [k8s\_control\_plane\_subnets\_cidr\_blocks](#output\_k8s\_control\_plane\_subnets\_cidr\_blocks) | The IPv4 CIDR blocks of all Kubernetes control plane subnets |
| <a name="output_k8s_worker_node_subnets_cidr_blocks"></a> [k8s\_worker\_node\_subnets\_cidr\_blocks](#output\_k8s\_worker\_node\_subnets\_cidr\_blocks) | The IPv4 CIDR blocks of all Kubernetes worker node subnets |
| <a name="output_k8s_all_kubernetes_subnets_cidr_blocks"></a> [k8s\_all\_kubernetes\_subnets\_cidr\_blocks](#output\_k8s\_all\_kubernetes\_subnets\_cidr\_blocks) | The IPv4 CIDR blocks of all Kubernetes subnets (excluding the NAT subnets) |
| <a name="output_k8s_all_subnets_cidr_blocks"></a> [k8s\_all\_subnets\_cidr\_blocks](#output\_k8s\_all\_subnets\_cidr\_blocks) | The IPv4 CIDR blocks of all Kubernetes subnets (including the NAT subnets) |
| <a name="output_k8s_nat_subnet_id_az"></a> [k8s\_nat\_subnet\_id\_az](#output\_k8s\_nat\_subnet\_id\_az) | The IDs of all NAT subnets mapped to their availability zone |
| <a name="output_k8s_all_kubernetes_public_subnet_id"></a> [k8s\_all\_kubernetes\_public\_subnet\_id](#output\_k8s\_all\_kubernetes\_public\_subnet\_id) | The IDs of all public Kubernetes subnets (excluding the NAT subnets) |
| <a name="output_k8s_all_public_subnet_id"></a> [k8s\_all\_public\_subnet\_id](#output\_k8s\_all\_public\_subnet\_id) | The IDs of all public subnets (including the NAT subnets) |
| <a name="output_k8s_all_kubernetes_private_subnet_id"></a> [k8s\_all\_kubernetes\_private\_subnet\_id](#output\_k8s\_all\_kubernetes\_private\_subnet\_id) | The IDs of all private Kubernetes subnets (excluding the NAT subnets) |
| <a name="output_k8s_all_kubernetes_private_subnet_id_az"></a> [k8s\_all\_kubernetes\_private\_subnet\_id\_az](#output\_k8s\_all\_kubernetes\_private\_subnet\_id\_az) | The IDs of all private Kubernetes subnets mapped to their availability zones |
| <a name="output_k8s_all_kubernetes_subnet_id"></a> [k8s\_all\_kubernetes\_subnet\_id](#output\_k8s\_all\_kubernetes\_subnet\_id) | The IDs of all Kubernetes subnets (excluding the NAT subnets) |
| <a name="output_k8s_all_subnet_id"></a> [k8s\_all\_subnet\_id](#output\_k8s\_all\_subnet\_id) | The IDs of all subnets (including the NAT subnets) |
| <a name="output_k8s_all_kubernetes_subnet_type_to_id"></a> [k8s\_all\_kubernetes\_subnet\_type\_to\_id](#output\_k8s\_all\_kubernetes\_subnet\_type\_to\_id) | Subnet mapping (excluding the NAT subnets) in the form of "[subnet type: public/private]@[subnet usage: control\_plane/worker\_node]@[Availability zone: a/b/c]@[subnet usage extra: *]" to "[subnet ID]" |

<!-- END_TF_DOCS -->