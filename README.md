# aft-customization-automation

# Overview
PoC Terraform module for automating customization pipeline invokation in Account Factory for Terraform (AFT), bypassing the manual step of triggering the account customization step function manually on changes.

![Alt text](img/invokation.png?raw=true "Overview")

# Prerequisites
- AFT framework deployed
- AFT repos hosted on Github

# Deployment
Deploys into AFT management account. The module creates workflow for one customization repository, so to enable automatic invokation for both global customization and account customization you need to deploy the module for each repository.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.11.0, < 6.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.67.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.2 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.account-customization-invoker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_codebuild_project.account_customization_invoker_pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codepipeline.codestar_customization_invoker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_codestarconnections_connection.github](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codestarconnections_connection) | resource |
| [aws_iam_role.customization_invoker_codepipeline_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.customization_invoker_codepipeline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_kms_alias.invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.codepipeline_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.aft-codepipeline-customizations-block-public-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.aft-codepipeline-customizations-bucket-encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.codepipeline_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [random_string.codepipeline_bucket_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_kms_key.aft](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_s3_bucket.codepipeline_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |
| [local_file.account_request_buildspec](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aft_kms_key_alias"></a> [aft\_kms\_key\_alias](#input\_aft\_kms\_key\_alias) | The alias of the KMS key used by AFT. | `string` | `"alias/aft"` | no |
| <a name="input_codepipeline_s3_bucket_name"></a> [codepipeline\_s3\_bucket\_name](#input\_codepipeline\_s3\_bucket\_name) | The name of the S3 bucket to store the CodePipeline artifacts. If not given one will be created. | `string` | `""` | no |
| <a name="input_codestar_connection_arn"></a> [codestar\_connection\_arn](#input\_codestar\_connection\_arn) | The ARN of the CodeStar connection | `string` | `""` | no |
| <a name="input_customization_name"></a> [customization\_name](#input\_customization\_name) | The name of the customization | `string` | n/a | yes |
| <a name="input_customizations_repo_branch"></a> [customizations\_repo\_branch](#input\_customizations\_repo\_branch) | The branch of the repository containing the customizations | `string` | n/a | yes |
| <a name="input_customizations_repo_name"></a> [customizations\_repo\_name](#input\_customizations\_repo\_name) | The name of the repository containing the customizations | `string` | n/a | yes |
| <a name="input_global_codebuild_timeout"></a> [global\_codebuild\_timeout](#input\_global\_codebuild\_timeout) | The timeout in minutes for the CodeBuild project | `number` | `300` | no |
| <a name="input_key_arn"></a> [key\_arn](#input\_key\_arn) | The ARN of the KMS key to use for encrypting the CodePipeline artifacts. If not given one will be created. | `string` | `""` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | The number of days to retain logs | `number` | `7` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codepipeline_arn"></a> [codepipeline\_arn](#output\_codepipeline\_arn) | ARN of the CodePipeline |
| <a name="output_codepipeline_bucket_arn"></a> [codepipeline\_bucket\_arn](#output\_codepipeline\_bucket\_arn) | ARN of the S3 bucket to store the CodePipeline artifacts |
| <a name="output_codepipeline_bucket_name"></a> [codepipeline\_bucket\_name](#output\_codepipeline\_bucket\_name) | Name of the S3 bucket to store the CodePipeline artifacts |
| <a name="output_codestar_connection_arn"></a> [codestar\_connection\_arn](#output\_codestar\_connection\_arn) | ARN of the CodeStar connection |
| <a name="output_invokation_kms_key_arn"></a> [invokation\_kms\_key\_arn](#output\_invokation\_kms\_key\_arn) | ARN of the KMS key used to encrypt the CodePipeline artifacts |
<!-- END_TF_DOCS -->
