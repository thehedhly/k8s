<!-- BEGIN_TF_DOCS -->

# k8s/key_pair

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
| [aws_key_pair.k8s](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/key_pair) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k8s_common_tags"></a> [k8s\_common\_tags](#input\_k8s\_common\_tags) | The common AWS Tags to apply on all module's resources | `map(string)` | <pre>{<br>  "owner": "senjoux",<br>  "project": "lab",<br>  "stage": "dev"<br>}</pre> | no |
| <a name="input_k8s_region"></a> [k8s\_region](#input\_k8s\_region) | The AWS region for provisioning the Kubernetes cluster | `string` | n/a | yes |
| <a name="input_k8s_key_pair_existant_key_pair_name"></a> [k8s\_key\_pair\_existant\_key\_pair\_name](#input\_k8s\_key\_pair\_existant\_key\_pair\_name) | The existant AWS key pair name. If no existant key pair name if provided, a new AWS key pair will be created. The AWS key pair will be provided to the Kubernetes AWS EC2 instance(s) on provisioing | `string` | `null` | no |
| <a name="input_k8s_key_pair_public_key_file"></a> [k8s\_key\_pair\_public\_key\_file](#input\_k8s\_key\_pair\_public\_key\_file) | The SSH public key file for creating the new AWS key pair. The key will be used for SSH accessing the Kubernetes AWS EC2 instance(s) | `string` | `null` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_key_pair_key_name"></a> [k8s\_key\_pair\_key\_name](#output\_k8s\_key\_pair\_key\_name) | The AWS key pair which will be provided to the Kubernetes AWS EC2 instance(s) on provisioing |

<!-- END_TF_DOCS -->