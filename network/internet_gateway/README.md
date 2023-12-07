<!-- BEGIN_TF_DOCS -->

# k8s/network/internet_gateway

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
| [aws_internet_gateway.k8s](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/internet_gateway) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k8s_common_tags"></a> [k8s\_common\_tags](#input\_k8s\_common\_tags) | The common AWS Tags to apply on all module's resources | `map(string)` | <pre>{<br>  "owner": "senjoux",<br>  "project": "lab",<br>  "stage": "dev"<br>}</pre> | no |
| <a name="input_k8s_region"></a> [k8s\_region](#input\_k8s\_region) | The AWS region for provisioning the Kubernetes cluster | `string` | n/a | yes |
| <a name="input_k8s_vpc_id"></a> [k8s\_vpc\_id](#input\_k8s\_vpc\_id) | The Kubernetes AWS VPC ID | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_internet_gateway_id"></a> [k8s\_internet\_gateway\_id](#output\_k8s\_internet\_gateway\_id) | The Kuberntes VPC's Internet Gateway ID |

<!-- END_TF_DOCS -->