# sre-coding-challenge
Public Repo for Altais Coding Challenge

## Requirements

- `terraform`
- `python`
- AWS Credentials for the target AWS account
- [`pre-commit`](https://github.com/antonbabenko/pre-commit-terraform#1-install-dependencies)
- [`checkov`](https://github.com/bridgecrewio/checkov)
- [`tflint`](https://github.com/terraform-linters/tflint)
- [`terraform-docs`](https://github.com/terraform-docs/terraform-docs)

## Run the project

Start the project 
`terraform init`

Apply the changes
`terraform apply --auto-approve`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.74.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2_instance"></a> [ec2\_instance](#module\_ec2\_instance) | terraform-aws-modules/ec2-instance/aws | 3.4.0 |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | 2.14.1 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | 4.8.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 3.12.0 |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket_notification.this](https://registry.terraform.io/providers/hashicorp/aws/3.74.0/docs/resources/s3_bucket_notification) | resource |
| [aws_s3_bucket_object.object](https://registry.terraform.io/providers/hashicorp/aws/3.74.0/docs/resources/s3_bucket_object) | resource |
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/3.74.0/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.default](https://registry.terraform.io/providers/hashicorp/aws/3.74.0/docs/resources/sns_topic_policy) | resource |
| [random_integer.random](https://registry.terraform.io/providers/hashicorp/random/3.1.0/docs/resources/integer) | resource |
| [aws_iam_policy_document.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/3.74.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | The environment to run the project | `string` | `"dev"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_instance_arn"></a> [ec2\_instance\_arn](#output\_ec2\_instance\_arn) | The ARN of the instance |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The ARN of the bucket. Will be of format arn:aws:s3:::bucketname. |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | The name of the bucket. |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | The ARN of the VPC |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Architecture

![Alt text](images/Architecture.png?raw=true "Architecture")

## Web Site

Only accessible with `http://EC2-IP`, the IP is in the outputs.