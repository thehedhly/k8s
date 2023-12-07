<!-- BEGIN_TF_DOCS -->

# Simple Kubernetes Cluster AWS-Infrastructure
## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.15.0 |
## Providers

No providers.
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_k8s"></a> [k8s](#module\_k8s) | ../ | n/a |
## Resources

No resources.
## Inputs

No inputs.
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_vpc_id"></a> [k8s\_vpc\_id](#output\_k8s\_vpc\_id) | The Kubernetes AWS VPC ID |
| <a name="output_k8s_vpc_name"></a> [k8s\_vpc\_name](#output\_k8s\_vpc\_name) | The Kubernetes AWS VPC name |
| <a name="output_k8s_all_kubernetes_subnet_id"></a> [k8s\_all\_kubernetes\_subnet\_id](#output\_k8s\_all\_kubernetes\_subnet\_id) | The IDs of all Kubernetes subnets (excluding the NAT subnets) |
| <a name="output_k8s_all_subnet_id"></a> [k8s\_all\_subnet\_id](#output\_k8s\_all\_subnet\_id) | The IDs of all subnets (including the NAT subnets) |
| <a name="output_k8s_nat_subnet_id_az"></a> [k8s\_nat\_subnet\_id\_az](#output\_k8s\_nat\_subnet\_id\_az) | The IDs of all NAT subnets mapped to their availability zone |
| <a name="output_k8s_all_kubernetes_private_subnet_id_az"></a> [k8s\_all\_kubernetes\_private\_subnet\_id\_az](#output\_k8s\_all\_kubernetes\_private\_subnet\_id\_az) | The IDs of all private Kubernetes subnets mapped to their availability zones |
| <a name="output_k8s_nat_eip_az"></a> [k8s\_nat\_eip\_az](#output\_k8s\_nat\_eip\_az) | The IDs of all Elastic IP addresses to be used for creating the NATs |
| <a name="output_k8s_nat_az"></a> [k8s\_nat\_az](#output\_k8s\_nat\_az) | The IDs of all NAT mapped to their NAT availability zone |
| <a name="output_k8s_internet_gateway_id"></a> [k8s\_internet\_gateway\_id](#output\_k8s\_internet\_gateway\_id) | The Kuberntes VPC's Internet Gateway ID |
| <a name="output_k8s_internet_gateway_access_route_table_id"></a> [k8s\_internet\_gateway\_access\_route\_table\_id](#output\_k8s\_internet\_gateway\_access\_route\_table\_id) | The ID of AWS Route Table used for accessing the internet from the Kubernetes AWS Subnets |
| <a name="output_k8s_nat_gateway_access_route_table_id"></a> [k8s\_nat\_gateway\_access\_route\_table\_id](#output\_k8s\_nat\_gateway\_access\_route\_table\_id) | The ID of AWS Route Table used for accessing NAT Gateway from the Kubernetes AWS Subnets |
| <a name="output_k8s_public_control_plane_security_group_ids"></a> [k8s\_public\_control\_plane\_security\_group\_ids](#output\_k8s\_public\_control\_plane\_security\_group\_ids) | The IDs of all AWS security groups to be used by public Kubernetes control planes |
| <a name="output_k8s_private_control_plane_security_group_ids"></a> [k8s\_private\_control\_plane\_security\_group\_ids](#output\_k8s\_private\_control\_plane\_security\_group\_ids) | The IDs of all AWS security groups to be used by private Kubernetes control planes |
| <a name="output_k8s_public_worker_node_security_group_ids"></a> [k8s\_public\_worker\_node\_security\_group\_ids](#output\_k8s\_public\_worker\_node\_security\_group\_ids) | The IDs of all AWS security groups to be used by public Kubernetes worker nodes |
| <a name="output_k8s_private_worker_node_security_group_ids"></a> [k8s\_private\_worker\_node\_security\_group\_ids](#output\_k8s\_private\_worker\_node\_security\_group\_ids) | The IDs of all AWS security groups to be used by private Kubernetes worker nodes |
| <a name="output_k8s_key_pair_key_name"></a> [k8s\_key\_pair\_key\_name](#output\_k8s\_key\_pair\_key\_name) | The AWS key pair which will be provided to the Kubernetes AWS EC2 instance(s) on provisioing |
| <a name="output_k8s_public_control_planes"></a> [k8s\_public\_control\_planes](#output\_k8s\_public\_control\_planes) | The list of created public Kubernetes control plane AWS EC2 instance(s). The details cover the ID, public\_ip, Name tag, usage tag and usage extra tag of the EC2 instance |
| <a name="output_k8s_private_control_planes"></a> [k8s\_private\_control\_planes](#output\_k8s\_private\_control\_planes) | The list of created private Kubernetes control plane AWS EC2 instance(s). The details cover the ID, public\_ip, Name tag, usage tag and usage extra tag of the EC2 instance |
| <a name="output_k8s_public_worker_nodes"></a> [k8s\_public\_worker\_nodes](#output\_k8s\_public\_worker\_nodes) | The list of created public Kubernetes worker node AWS EC2 instance(s). The details cover the ID, public\_ip, Name tag, usage tag and usage extra tag of the EC2 instance |
| <a name="output_k8s_private_worker_nodes"></a> [k8s\_private\_worker\_nodes](#output\_k8s\_private\_worker\_nodes) | The list of created private Kubernetes worker node AWS EC2 instance(s). The details cover the ID, public\_ip, Name tag, usage tag and usage extra tag of the EC2 instance |

<!-- END_TF_DOCS -->