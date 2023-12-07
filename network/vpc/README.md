<!-- BEGIN_TF_DOCS -->

# k8s/vpc

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
| [aws_vpc.k8s](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/vpc) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k8s_common_tags"></a> [k8s\_common\_tags](#input\_k8s\_common\_tags) | The common AWS Tags to apply on all module's resources | `map(string)` | <pre>{<br>  "owner": "senjoux",<br>  "project": "lab",<br>  "stage": "dev"<br>}</pre> | no |
| <a name="input_k8s_region"></a> [k8s\_region](#input\_k8s\_region) | The AWS region for provisioning the Kubernetes cluster | `string` | n/a | yes |
| <a name="input_k8s_vpc_cidr_block"></a> [k8s\_vpc\_cidr\_block](#input\_k8s\_vpc\_cidr\_block) | The IPv4 CIDR block of the Kubernetes AWS VPC | `string` | n/a | yes |
| <a name="input_k8s_vpc_enable_dns_hostnames"></a> [k8s\_vpc\_enable\_dns\_hostnames](#input\_k8s\_vpc\_enable\_dns\_hostnames) | Enable or disable DNS hostnames. IF enabled, instances launched in the VPC receive public DNS hostnames that correspond to their public IP addresses | `bool` | `true` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_vpc_id"></a> [k8s\_vpc\_id](#output\_k8s\_vpc\_id) | The Kubernetes AWS VPC ID |
| <a name="output_k8s_vpc_name"></a> [k8s\_vpc\_name](#output\_k8s\_vpc\_name) | The Kubernetes AWS VPC name |

<!-- END_TF_DOCS -->