# Terraform EFS module

This module is not to be deployed directly.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.7.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_efs_file_system.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_kms_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.this_cidrs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_security_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.this_efs_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_subnet.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet_ids.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | CIDRs allowed to access the EFS. Must be a list of object containing “cidr” and “target” (the target of the CIDR). | `list` | `[]` | no |
| <a name="input_allowed_security_group_ids"></a> [allowed\_security\_group\_ids](#input\_allowed\_security\_group\_ids) | CIDRs allowed to access the EFS. Must be a list of object containing “cidr” and “target” (the target of the CIDR). | `list` | `[]` | no |
| <a name="input_efs_tags"></a> [efs\_tags](#input\_efs\_tags) | Tags specific for the EFS. Will be merged with tags. | `map` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether or not to enable this entire module or not. | `bool` | `true` | no |
| <a name="input_kms_key_alias_name"></a> [kms\_key\_alias\_name](#input\_kms\_key\_alias\_name) | Name of the KMS key alias to be used to encrypt the EFS. | `string` | `"alias/efs"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | ARN of the KMS key to be used to encrypt the EFS. Should be specified when kms\_key\_create is false. | `string` | `""` | no |
| <a name="input_kms_key_create"></a> [kms\_key\_create](#input\_kms\_key\_create) | Wheter or not it is needed to create the KMS key for the EFS. | `bool` | `true` | no |
| <a name="input_kms_key_name"></a> [kms\_key\_name](#input\_kms\_key\_name) | Name of the KMS key to be used to encrypt the EFS. | `string` | `"efs"` | no |
| <a name="input_kms_tags"></a> [kms\_tags](#input\_kms\_tags) | Tags specific for the KMS key for the EFS. Will be merged with tags. | `map` | `{}` | no |
| <a name="input_lifecycle_policy"></a> [lifecycle\_policy](#input\_lifecycle\_policy) | Lifecycle policy | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the EFS. | `string` | `"efs"` | no |
| <a name="input_performance_mode"></a> [performance\_mode](#input\_performance\_mode) | The file system performance mode. Can be either ”generalPurpose” or “maxIO”. | `string` | `"generalPurpose"` | no |
| <a name="input_provisioned_throughput_in_mibps"></a> [provisioned\_throughput\_in\_mibps](#input\_provisioned\_throughput\_in\_mibps) | The throughput, measured in MiB/s, that you want to provision for the file system. Only applicable with throughput\_mode set to “provisioned”. | `number` | `0` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of additionnal security group IDs to be used by the EFS mount targets. MUST be specified when no `allowed_cidrs` or `allowed_security_group_ids` is provided. | `list` | `[]` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of the security group to be used by the EFS mount targets. Security group will be create ONLY IF `allowed_cidrs` or `allowed_security_group_ids` is NOT an empty list. | `string` | `"efs"` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | Additionnal tags specific for the security group for the EFS mount targets. Will be merged with tags. | `map` | `{}` | no |
| <a name="input_ssm_parameter_enabled"></a> [ssm\_parameter\_enabled](#input\_ssm\_parameter\_enabled) | Whether or not to create SSM Parameters containing EFS data. | `bool` | `false` | no |
| <a name="input_ssm_parameter_prefix"></a> [ssm\_parameter\_prefix](#input\_ssm\_parameter\_prefix) | Prefix for the SSM Parameters created by this module. It should an absolute path without trailing slash (e.g /my/example/path). | `string` | `"/efs/module/default"` | no |
| <a name="input_ssm_parameter_tags"></a> [ssm\_parameter\_tags](#input\_ssm\_parameter\_tags) | Tags specific for the SSM Parameters for the EFS. Will be merged with tags. | `map` | `{}` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | IDs of the subnet where the EFS should be made available. If none are specified, it will be deployed in the default vpc WITHOUT mount targets. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be shared among all resources of this module. | `map` | `{}` | no |
| <a name="input_throughput_mode"></a> [throughput\_mode](#input\_throughput\_mode) | Throughput mode for the file system. Valid values: ”bursting”, “provisioned”. When using provisioned, also set provisioned\_throughput\_in\_mibps. | `string` | `"bursting"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs_arn"></a> [efs\_arn](#output\_efs\_arn) | Amazon Resource Name of the file system. |
| <a name="output_efs_dns_name"></a> [efs\_dns\_name](#output\_efs\_dns\_name) | The DNS name for the filesystem. |
| <a name="output_efs_id"></a> [efs\_id](#output\_efs\_id) | The ID that identifies the file system (e.g. fs-ccfc0d65). |
| <a name="output_efs_mount_target_ids"></a> [efs\_mount\_target\_ids](#output\_efs\_mount\_target\_ids) | The IDs of the EFS mount targets. |
| <a name="output_efs_mount_target_network_interface_ids"></a> [efs\_mount\_target\_network\_interface\_ids](#output\_efs\_mount\_target\_network\_interface\_ids) | The IDs of the network interfaces that Amazon EFS created when it created the mount targets. |
| <a name="output_kms_alias_arn"></a> [kms\_alias\_arn](#output\_kms\_alias\_arn) | The Amazon Resource Name (ARN) of the EFS key alias. This output will be empty if the KMS key was passed as variable. |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | The Amazon Resource Name (ARN) of the EFS key. This output will be empty if the KMS key was passed as variable. |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | The globally unique identifier for the EFS key. This output will be empty if the KMS key was passed as variable. |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the security group used for the EFS. This output will be empty if the security groups IDs were passed as variables. |
| <a name="output_security_group_rule_ids"></a> [security\_group\_rule\_ids](#output\_security\_group\_rule\_ids) | List of ID's of the security rules added to security group |
| <a name="output_ssm_parameter_arns"></a> [ssm\_parameter\_arns](#output\_ssm\_parameter\_arns) | The ARNs of the SSM Parameters for the EFS. |
| <a name="output_ssm_parameter_names"></a> [ssm\_parameter\_names](#output\_ssm\_parameter\_names) | The names of the SSM Parameters for the EFS. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
