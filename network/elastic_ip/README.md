<!-- BEGIN_TF_DOCS -->

# k8s/network/elastic_ip

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
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/eip) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k8s_common_tags"></a> [k8s\_common\_tags](#input\_k8s\_common\_tags) | The common AWS Tags to apply on all module's resources | `map(string)` | <pre>{<br>  "owner": "senjoux",<br>  "project": "lab",<br>  "stage": "dev"<br>}</pre> | no |
| <a name="input_k8s_region"></a> [k8s\_region](#input\_k8s\_region) | The AWS region for provisioning the Kubernetes cluster | `string` | n/a | yes |
| <a name="input_k8s_nat_subnets"></a> [k8s\_nat\_subnets](#input\_k8s\_nat\_subnets) | The list of AWS NAT subnets objects. <br>The NAT Subnets are all public AWS Subnets.<br>The NAT Subnets will be created only if "k8s\_use\_real\_private\_aws\_subnets" is set to "true". | `map(string)` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_nat_eip_az"></a> [k8s\_nat\_eip\_az](#output\_k8s\_nat\_eip\_az) | The IDs & Allocation IDs of all NAT Elastic IP addresses mapped to their NAT availability zone |

<!-- END_TF_DOCS -->