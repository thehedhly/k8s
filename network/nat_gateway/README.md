<!-- BEGIN_TF_DOCS -->

# k8s/network/nat_gateway

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
| [aws_nat_gateway.k8s_public](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/nat_gateway) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k8s_common_tags"></a> [k8s\_common\_tags](#input\_k8s\_common\_tags) | The common AWS Tags to apply on all module's resources | `map(string)` | <pre>{<br>  "owner": "senjoux",<br>  "project": "lab",<br>  "stage": "dev"<br>}</pre> | no |
| <a name="input_k8s_region"></a> [k8s\_region](#input\_k8s\_region) | The AWS region for provisioning the Kubernetes cluster | `string` | n/a | yes |
| <a name="input_k8s_nat_subnet_id_az"></a> [k8s\_nat\_subnet\_id\_az](#input\_k8s\_nat\_subnet\_id\_az) | The IDs of all NAT subnets mapped to their availability zone | `map(string)` | n/a | yes |
| <a name="input_k8s_nat_eip_az"></a> [k8s\_nat\_eip\_az](#input\_k8s\_nat\_eip\_az) | The IDs & Allocation IDs of all NAT Elastic IP addresses mapped to their NAT availability zone | <pre>map(object({<br>    allocation_id = string,<br>    id            = string,<br>  }))</pre> | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_nat_az"></a> [k8s\_nat\_az](#output\_k8s\_nat\_az) | The IDs of all NAT mapped to their NAT availability zone |

<!-- END_TF_DOCS -->