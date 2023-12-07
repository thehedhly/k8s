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
| [aws_iam_role.k8s_ec2_ssm](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/resources/iam_role) | resource |
| [aws_iam_policy.ssm_managed_instance_core](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.ec2_instance_assume_role](https://registry.terraform.io/providers/hashicorp/aws/5.15.0/docs/data-sources/iam_policy_document) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k8s_common_tags"></a> [k8s\_common\_tags](#input\_k8s\_common\_tags) | The common AWS Tags to apply on all module's resources | `map(string)` | <pre>{<br>  "owner": "senjoux",<br>  "project": "lab",<br>  "stage": "dev"<br>}</pre> | no |
| <a name="input_k8s_vpc_id"></a> [k8s\_vpc\_id](#input\_k8s\_vpc\_id) | The Kubernetes AWS VPC ID | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_ec2_ssm_role"></a> [k8s\_ec2\_ssm\_role](#output\_k8s\_ec2\_ssm\_role) | The AWS Role name for setting up the SSM AWS Instance-Profile |

<!-- END_TF_DOCS -->