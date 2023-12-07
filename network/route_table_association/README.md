<!-- BEGIN_TF_DOCS -->

# k8s/network/route_table_association
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
| [aws_route_table_association.k8s_internet_access_for_all_subnet](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.k8s_internet_access_for_public_subnet](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/route_table_association) | resource |
| [aws_route_table_association.k8s_nat_access_for_private_subnet](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/route_table_association) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k8s_internet_gateway_access_route_table_id"></a> [k8s\_internet\_gateway\_access\_route\_table\_id](#input\_k8s\_internet\_gateway\_access\_route\_table\_id) | The ID of AWS Route Table used for accessing the internet from the Kubernetes AWS Subnets | `string` | n/a | yes |
| <a name="input_k8s_nat_gateway_access_route_table_id"></a> [k8s\_nat\_gateway\_access\_route\_table\_id](#input\_k8s\_nat\_gateway\_access\_route\_table\_id) | The ID of AWS Route Table used for accessing NAT Gateway from the Kubernetes AWS Subnets | `map(string)` | n/a | yes |
| <a name="input_k8s_all_kubernetes_subnet_id"></a> [k8s\_all\_kubernetes\_subnet\_id](#input\_k8s\_all\_kubernetes\_subnet\_id) | The IDs of all Kubernetes cluster subnets (excluding the NAT subnets) | `list(string)` | n/a | yes |
| <a name="input_k8s_all_public_subnet_id"></a> [k8s\_all\_public\_subnet\_id](#input\_k8s\_all\_public\_subnet\_id) | The IDs of all public subnets (including the NAT subnets) | `list(string)` | n/a | yes |
| <a name="input_k8s_use_real_private_aws_subnets"></a> [k8s\_use\_real\_private\_aws\_subnets](#input\_k8s\_use\_real\_private\_aws\_subnets) | Control what type of subnets to use for private control planes & private worker nodes subnets."<br>Private subnets can be:<br>  - (per default) provisioned as public AWS subnets with blocked Ingress internet traffic on EC2 Instance Security Groups level, however Egress Internet access is allowed.<br>  - provisioned as real private AWS subnets (blocked Ingress internet traffic on subnet level). Egress Internet access follows through a NAT Gateway (extra costs apply) | `bool` | `false` | no |
| <a name="input_k8s_all_kubernetes_private_subnet_id_az"></a> [k8s\_all\_kubernetes\_private\_subnet\_id\_az](#input\_k8s\_all\_kubernetes\_private\_subnet\_id\_az) | The IDs of all private Kubernetes subnets mapped to their availability zoness | <pre>list(object({<br>    id = string,<br>    az = string,<br>  }))</pre> | `[]` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_aws_route_table_association_internet_access_for_all_subnet"></a> [k8s\_aws\_route\_table\_association\_internet\_access\_for\_all\_subnet](#output\_k8s\_aws\_route\_table\_association\_internet\_access\_for\_all\_subnet) | IDs of the internet route table association for all subnets |

<!-- END_TF_DOCS -->