<!-- BEGIN_TF_DOCS -->

# k8s/network/security_group

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
| [aws_security_group.k8s_etcd_client](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/security_group) | resource |
| [aws_security_group.k8s_etcd_peer_communication](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/security_group) | resource |
| [aws_security_group.k8s_kube_controller_manager](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/security_group) | resource |
| [aws_security_group.k8s_kube_scheduler](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/security_group) | resource |
| [aws_security_group.k8s_private_http](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/security_group) | resource |
| [aws_security_group.k8s_private_https](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/security_group) | resource |
| [aws_security_group.k8s_private_kubelet_api](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/security_group) | resource |
| [aws_security_group.k8s_private_kubernetes_api_server](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/security_group) | resource |
| [aws_security_group.k8s_private_node_port_services](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/security_group) | resource |
| [aws_security_group.k8s_private_ssh](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/security_group) | resource |
| [aws_security_group.k8s_public_http](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/security_group) | resource |
| [aws_security_group.k8s_public_https](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/security_group) | resource |
| [aws_security_group.k8s_public_kubelet_api](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/security_group) | resource |
| [aws_security_group.k8s_public_kubernetes_api_server](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/security_group) | resource |
| [aws_security_group.k8s_public_node_port_services](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/security_group) | resource |
| [aws_security_group.k8s_public_ssh](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/security_group) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k8s_common_tags"></a> [k8s\_common\_tags](#input\_k8s\_common\_tags) | The common AWS Tags to apply on all module's resources | `map(string)` | <pre>{<br>  "owner": "senjoux",<br>  "project": "lab",<br>  "stage": "dev"<br>}</pre> | no |
| <a name="input_k8s_vpc_id"></a> [k8s\_vpc\_id](#input\_k8s\_vpc\_id) | The Kubernetes AWS VPC ID | `string` | n/a | yes |
| <a name="input_k8s_region"></a> [k8s\_region](#input\_k8s\_region) | The AWS region for provisioning the Kubernetes cluster | `string` | n/a | yes |
| <a name="input_k8s_all_kubernetes_subnets_cidr_blocks"></a> [k8s\_all\_kubernetes\_subnets\_cidr\_blocks](#input\_k8s\_all\_kubernetes\_subnets\_cidr\_blocks) | The IPv4 CIDR blocks of all Kubernetes AWS subnets (excluding the NAT subnets) | `set(string)` | `[]` | no |
| <a name="input_k8s_all_subnets_cidr_blocks"></a> [k8s\_all\_subnets\_cidr\_blocks](#input\_k8s\_all\_subnets\_cidr\_blocks) | The IPv4 CIDR blocks of all AWS subnets (including the NAT subnets) | `set(string)` | `[]` | no |
| <a name="input_k8s_control_plane_subnets_cidr_blocks"></a> [k8s\_control\_plane\_subnets\_cidr\_blocks](#input\_k8s\_control\_plane\_subnets\_cidr\_blocks) | The IPv4 CIDR blocks of all Kubernetes control plane AWS subnets | `set(string)` | `[]` | no |
| <a name="input_k8s_worker_node_subnets_cidr_blocks"></a> [k8s\_worker\_node\_subnets\_cidr\_blocks](#input\_k8s\_worker\_node\_subnets\_cidr\_blocks) | The IPv4 CIDR blocks of all Kubernetes worker node AWS subnets | `set(string)` | `[]` | no |
| <a name="input_k8s_ssh_ingress_public_cidr_blocks"></a> [k8s\_ssh\_ingress\_public\_cidr\_blocks](#input\_k8s\_ssh\_ingress\_public\_cidr\_blocks) | The ingress IPv4 CIDR blocks for public SSH security group | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_k8s_ssh_ingress_private_cidr_blocks"></a> [k8s\_ssh\_ingress\_private\_cidr\_blocks](#input\_k8s\_ssh\_ingress\_private\_cidr\_blocks) | The ingress IPv4 CIDR blocks for private SSH security group | `list(string)` | `[]` | no |
| <a name="input_k8s_http_ingress_public_cidr_blocks"></a> [k8s\_http\_ingress\_public\_cidr\_blocks](#input\_k8s\_http\_ingress\_public\_cidr\_blocks) | The ingress IPv4 CIDR blocks for public HTTP security group | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_k8s_http_ingress_private_cidr_blocks"></a> [k8s\_http\_ingress\_private\_cidr\_blocks](#input\_k8s\_http\_ingress\_private\_cidr\_blocks) | The ingress IPv4 CIDR blocks for private HTTP security group | `list(string)` | `[]` | no |
| <a name="input_k8s_https_ingress_public_cidr_blocks"></a> [k8s\_https\_ingress\_public\_cidr\_blocks](#input\_k8s\_https\_ingress\_public\_cidr\_blocks) | The ingress IPv4 CIDR blocks for public HTTPS security group | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_k8s_https_ingress_private_cidr_blocks"></a> [k8s\_https\_ingress\_private\_cidr\_blocks](#input\_k8s\_https\_ingress\_private\_cidr\_blocks) | The ingress IPv4 CIDR blocks for private HTTPS security group | `list(string)` | `[]` | no |
| <a name="input_k8s_kubernetes_api_server_port"></a> [k8s\_kubernetes\_api\_server\_port](#input\_k8s\_kubernetes\_api\_server\_port) | The Kubernetes API server port number | `number` | `6443` | no |
| <a name="input_k8s_kubelet_api_port"></a> [k8s\_kubelet\_api\_port](#input\_k8s\_kubelet\_api\_port) | The Kubelet API port number | `number` | `10250` | no |
| <a name="input_k8s_kube_scheduler_port"></a> [k8s\_kube\_scheduler\_port](#input\_k8s\_kube\_scheduler\_port) | The Kube Scheduler port number | `number` | `10259` | no |
| <a name="input_k8s_kube_controller_manager_port"></a> [k8s\_kube\_controller\_manager\_port](#input\_k8s\_kube\_controller\_manager\_port) | The Kube Controller Manager port number | `number` | `10257` | no |
| <a name="input_k8s_etcd_client_port"></a> [k8s\_etcd\_client\_port](#input\_k8s\_etcd\_client\_port) | The ETCD Client port number | `number` | `2379` | no |
| <a name="input_k8s_etcd_peer_communication_port"></a> [k8s\_etcd\_peer\_communication\_port](#input\_k8s\_etcd\_peer\_communication\_port) | The ETCD Peer Communication port number | `number` | `2380` | no |
| <a name="input_k8s_node_port_services_port_from"></a> [k8s\_node\_port\_services\_port\_from](#input\_k8s\_node\_port\_services\_port\_from) | The NodePort Services ports | `number` | `30000` | no |
| <a name="input_k8s_node_port_services_port_to"></a> [k8s\_node\_port\_services\_port\_to](#input\_k8s\_node\_port\_services\_port\_to) | The NodePort Services ports | `number` | `32767` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_public_ssh_security_group_id"></a> [k8s\_public\_ssh\_security\_group\_id](#output\_k8s\_public\_ssh\_security\_group\_id) | The ID of public SSH AWS security group |
| <a name="output_k8s_private_ssh_security_group_id"></a> [k8s\_private\_ssh\_security\_group\_id](#output\_k8s\_private\_ssh\_security\_group\_id) | The ID of private SSH AWS security group |
| <a name="output_k8s_public_http_security_group_id"></a> [k8s\_public\_http\_security\_group\_id](#output\_k8s\_public\_http\_security\_group\_id) | The ID of public HTTP AWS security group |
| <a name="output_k8s_private_http_security_group_id"></a> [k8s\_private\_http\_security\_group\_id](#output\_k8s\_private\_http\_security\_group\_id) | The ID of private HTTP AWS security group |
| <a name="output_k8s_public_https_security_group_id"></a> [k8s\_public\_https\_security\_group\_id](#output\_k8s\_public\_https\_security\_group\_id) | The ID of public HTTPS AWS security group |
| <a name="output_k8s_private_https_security_group_id"></a> [k8s\_private\_https\_security\_group\_id](#output\_k8s\_private\_https\_security\_group\_id) | The ID of private HTTPS AWS security group |
| <a name="output_k8s_public_kubernetes_api_server_security_group_id"></a> [k8s\_public\_kubernetes\_api\_server\_security\_group\_id](#output\_k8s\_public\_kubernetes\_api\_server\_security\_group\_id) | The ID of the public Kubernetes API server AWS security group |
| <a name="output_k8s_private_kubernetes_api_server_security_group_id"></a> [k8s\_private\_kubernetes\_api\_server\_security\_group\_id](#output\_k8s\_private\_kubernetes\_api\_server\_security\_group\_id) | The ID of the private the Kubernetes API server AWS security group |
| <a name="output_k8s_public_kubelet_api_security_group_id"></a> [k8s\_public\_kubelet\_api\_security\_group\_id](#output\_k8s\_public\_kubelet\_api\_security\_group\_id) | The ID of the public Kubelet API AWS security group |
| <a name="output_k8s_private_kubelet_api_security_group_id"></a> [k8s\_private\_kubelet\_api\_security\_group\_id](#output\_k8s\_private\_kubelet\_api\_security\_group\_id) | The ID of the private Kubelet API security group |
| <a name="output_k8s_kube_scheduler_security_group_id"></a> [k8s\_kube\_scheduler\_security\_group\_id](#output\_k8s\_kube\_scheduler\_security\_group\_id) | The ID of the Kube Scheduler AWS security group |
| <a name="output_k8s_kube_controller_manager_security_group_id"></a> [k8s\_kube\_controller\_manager\_security\_group\_id](#output\_k8s\_kube\_controller\_manager\_security\_group\_id) | The ID of the Kube Controller Manager AWS security group |
| <a name="output_k8s_etcd_client_security_group_id"></a> [k8s\_etcd\_client\_security\_group\_id](#output\_k8s\_etcd\_client\_security\_group\_id) | The ID of the ETCD Client AWS security group |
| <a name="output_k8s_public_node_port_services_security_group_id"></a> [k8s\_public\_node\_port\_services\_security\_group\_id](#output\_k8s\_public\_node\_port\_services\_security\_group\_id) | The ID of the public Node Port services AWS security group |
| <a name="output_k8s_private_node_port_services_security_group_id"></a> [k8s\_private\_node\_port\_services\_security\_group\_id](#output\_k8s\_private\_node\_port\_services\_security\_group\_id) | The ID of the private Node Port services AWS security group |
| <a name="output_k8s_public_control_plane_security_group_ids"></a> [k8s\_public\_control\_plane\_security\_group\_ids](#output\_k8s\_public\_control\_plane\_security\_group\_ids) | The IDs of all AWS security groups to be used by public Kubernetes control planes |
| <a name="output_k8s_private_control_plane_security_group_ids"></a> [k8s\_private\_control\_plane\_security\_group\_ids](#output\_k8s\_private\_control\_plane\_security\_group\_ids) | The IDs of all AWS security groups to be used by private Kubernetes control planes |
| <a name="output_k8s_public_worker_node_security_group_ids"></a> [k8s\_public\_worker\_node\_security\_group\_ids](#output\_k8s\_public\_worker\_node\_security\_group\_ids) | The IDs of all AWS security groups to be used by public Kubernetes worker nodes |
| <a name="output_k8s_private_worker_node_security_group_ids"></a> [k8s\_private\_worker\_node\_security\_group\_ids](#output\_k8s\_private\_worker\_node\_security\_group\_ids) | The IDs of all AWS security groups to be used by private Kubernetes worker nodes |

<!-- END_TF_DOCS -->