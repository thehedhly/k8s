<!-- BEGIN_TF_DOCS -->

# k8s/iam/role

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
| [aws_instance.private_control_plane](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/instance) | resource |
| [aws_instance.private_worker_node](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/instance) | resource |
| [aws_instance.public_control_plane](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/instance) | resource |
| [aws_instance.public_worker_node](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/instance) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k8s_common_tags"></a> [k8s\_common\_tags](#input\_k8s\_common\_tags) | The common AWS Tags to apply on all module's resources | `map(string)` | <pre>{<br>  "owner": "senjoux",<br>  "project": "lab",<br>  "stage": "dev"<br>}</pre> | no |
| <a name="input_k8s_vpc_id"></a> [k8s\_vpc\_id](#input\_k8s\_vpc\_id) | The Kubernetes AWS VPC ID | `string` | n/a | yes |
| <a name="input_k8s_all_kubernetes_subnet_type_to_id"></a> [k8s\_all\_kubernetes\_subnet\_type\_to\_id](#input\_k8s\_all\_kubernetes\_subnet\_type\_to\_id) | Subnet mapping in the form of "[subnet type: public/private]@[subnet usage: control\_plane/worker\_node]@[Availability zone: a/b/c]@[subnet usage extra: *]" to "[subnet ID]" | `map(string)` | n/a | yes |
| <a name="input_k8s_use_real_private_aws_subnets"></a> [k8s\_use\_real\_private\_aws\_subnets](#input\_k8s\_use\_real\_private\_aws\_subnets) | Control what type of subnets to use for private control planes & private worker nodes subnets."<br>Private subnets can be:<br>  - (per default) provisioned as public AWS subnets with blocked Ingress internet traffic on EC2 Instance Security Groups level, however Egress Internet access is allowed.<br>  - provisioned as real private AWS subnets (blocked Ingress internet traffic on subnet level). Egress Internet access follows through a NAT Gateway (extra costs apply) | `bool` | `false` | no |
| <a name="input_k8s_public_control_plane_security_group_ids"></a> [k8s\_public\_control\_plane\_security\_group\_ids](#input\_k8s\_public\_control\_plane\_security\_group\_ids) | The IDs of all AWS security groups to be used by public Kubernetes control planes | `set(string)` | n/a | yes |
| <a name="input_k8s_private_control_plane_security_group_ids"></a> [k8s\_private\_control\_plane\_security\_group\_ids](#input\_k8s\_private\_control\_plane\_security\_group\_ids) | The IDs of all AWS security groups to be used by private Kubernetes control planes | `set(string)` | n/a | yes |
| <a name="input_k8s_public_worker_node_security_group_ids"></a> [k8s\_public\_worker\_node\_security\_group\_ids](#input\_k8s\_public\_worker\_node\_security\_group\_ids) | The IDs of all AWS security groups to be used by public Kubernetes worker nodes | `set(string)` | n/a | yes |
| <a name="input_k8s_private_worker_node_security_group_ids"></a> [k8s\_private\_worker\_node\_security\_group\_ids](#input\_k8s\_private\_worker\_node\_security\_group\_ids) | The IDs of all AWS security groups to be used by private Kubernetes worker nodes | `set(string)` | n/a | yes |
| <a name="input_k8s_ec2_ssm_instance_profile_name"></a> [k8s\_ec2\_ssm\_instance\_profile\_name](#input\_k8s\_ec2\_ssm\_instance\_profile\_name) | The name of the SSM AWS Instance profile | `string` | n/a | yes |
| <a name="input_k8s_key_pair_key_name"></a> [k8s\_key\_pair\_key\_name](#input\_k8s\_key\_pair\_key\_name) | The AWS key pair which will be provided to the Kubernetes AWS EC2 instance(s) on provisioing | `string` | n/a | yes |
| <a name="input_k8s_ec2_instance_ami"></a> [k8s\_ec2\_instance\_ami](#input\_k8s\_ec2\_instance\_ami) | The AWS AMI to be used for AWS EC2 instance(s) creation | `string` | n/a | yes |
| <a name="input_k8s_control_plane_instances"></a> [k8s\_control\_plane\_instances](#input\_k8s\_control\_plane\_instances) | The list of Kubernetes control plane AWS EC2 instance(s) objects | <pre>list(object({<br>    instance_type       = string,<br>    type                = string,<br>    subnet_usage_filter = string,<br>    az_filter           = optional(string, "a"),<br>  }))</pre> | n/a | yes |
| <a name="input_k8s_worker_node_instances"></a> [k8s\_worker\_node\_instances](#input\_k8s\_worker\_node\_instances) | The list of Kubernetes worker node AWS EC2 instance(s) objects | <pre>list(object({<br>    instance_type       = string,<br>    type                = string,<br>    subnet_usage_filter = string,<br>    az_filter           = optional(string, "a"),<br>  }))</pre> | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_public_control_planes"></a> [k8s\_public\_control\_planes](#output\_k8s\_public\_control\_planes) | The list of created public Kubernetes control plane AWS EC2 instance(s). The details cover the ID, Name tag, public\_ip, public\_dns, usage tag and usage extra tag of the EC2 instance |
| <a name="output_k8s_private_control_planes"></a> [k8s\_private\_control\_planes](#output\_k8s\_private\_control\_planes) | The list of created private Kubernetes control plane AWS EC2 instance(s). The details cover the ID, Name tag, public\_ip, public\_dns, usage tag and usage extra tag of the EC2 instance |
| <a name="output_k8s_public_worker_nodes"></a> [k8s\_public\_worker\_nodes](#output\_k8s\_public\_worker\_nodes) | The list of created public Kubernetes worker node AWS EC2 instance(s). The details cover the ID, Name tag, public\_ip, public\_dns, usage tag and usage extra tag of the EC2 instance |
| <a name="output_k8s_private_worker_nodes"></a> [k8s\_private\_worker\_nodes](#output\_k8s\_private\_worker\_nodes) | The list of created private Kubernetes worker node AWS EC2 instance(s). The details cover the ID, Name tag, public\_ip, public\_dns, usage tag and usage extra tag of the EC2 instance |

<!-- END_TF_DOCS -->