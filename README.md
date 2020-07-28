# Terraform EFS module

This module is not to be deployed directly.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | >= 2.7.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.7.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_cidrs | CIDRs allowed to access the EFS. Must be a list of object containing “cidr” and “target” (the target of the CIDR). | `list` | `[]` | no |
| allowed\_security\_group\_ids | CIDRs allowed to access the EFS. Must be a list of object containing “cidr” and “target” (the target of the CIDR). | `list` | `[]` | no |
| efs\_tags | Tags specific for the EFS. Will be merged with tags. | `map` | `{}` | no |
| enabled | Whether or not to enable this entire module or not. | `bool` | `true` | no |
| kms\_key\_alias\_name | Name of the KMS key alias to be used to encrypt the EFS. | `string` | `"alias/efs"` | no |
| kms\_key\_arn | ARN of the KMS key to be used to encrypt the EFS. Should be specified when kms\_key\_create is false. | `string` | `""` | no |
| kms\_key\_create | Wheter or not it is needed to create the KMS key for the EFS. | `bool` | `true` | no |
| kms\_key\_name | Name of the KMS key to be used to encrypt the EFS. | `string` | `"efs"` | no |
| kms\_tags | Tags specific for the KMS key for the EFS. Will be merged with tags. | `map` | `{}` | no |
| lifecycle\_policy | Lifecycle policy | `list(string)` | `[]` | no |
| name | Name of the EFS. | `string` | `"efs"` | no |
| performance\_mode | The file system performance mode. Can be either ”generalPurpose” or “maxIO”. | `string` | `"generalPurpose"` | no |
| provisioned\_throughput\_in\_mibps | The throughput, measured in MiB/s, that you want to provision for the file system. Only applicable with throughput\_mode set to “provisioned”. | `number` | `0` | no |
| security\_group\_ids | List of additionnal security group IDs to be used by the EFS mount targets. MUST be specified when no `allowed_cidrs` or `allowed_security_group_ids` is provided. | `list` | `[]` | no |
| security\_group\_name | Name of the security group to be used by the EFS mount targets. Security group will be create ONLY IF `allowed_cidrs` or `allowed_security_group_ids` is NOT an empty list. | `string` | `"efs"` | no |
| security\_group\_tags | Additionnal tags specific for the security group for the EFS mount targets. Will be merged with tags. | `map` | `{}` | no |
| ssm\_parameter\_enabled | Whether or not to create SSM Parameters containing EFS data. | `bool` | `false` | no |
| ssm\_parameter\_prefix | Prefix for the SSM Parameters created by this module. It should an absolute path without trailing slash (e.g /my/example/path). | `string` | `"/efs/module/default"` | no |
| ssm\_parameter\_tags | Tags specific for the SSM Parameters for the EFS. Will be merged with tags. | `map` | `{}` | no |
| subnet\_ids | IDs of the subnet where the EFS should be made available. If none are specified, it will be deployed in the default vpc WITHOUT mount targets. | `list(string)` | `[]` | no |
| tags | Tags to be shared among all resources of this module. | `map` | `{}` | no |
| throughput\_mode | Throughput mode for the file system. Valid values: ”bursting”, “provisioned”. When using provisioned, also set provisioned\_throughput\_in\_mibps. | `string` | `"bursting"` | no |

## Outputs

| Name | Description |
|------|-------------|
| efs\_arn | Amazon Resource Name of the file system. |
| efs\_dns\_name | The DNS name for the filesystem. |
| efs\_id | The ID that identifies the file system (e.g. fs-ccfc0d65). |
| efs\_mount\_target\_ids | The IDs of the EFS mount targets. |
| efs\_mount\_target\_network\_interface\_ids | The IDs of the network interfaces that Amazon EFS created when it created the mount targets. |
| kms\_alias\_arn | The Amazon Resource Name (ARN) of the EFS key alias. This output will be empty if the KMS key was passed as variable. |
| kms\_key\_arn | The Amazon Resource Name (ARN) of the EFS key. This output will be empty if the KMS key was passed as variable. |
| kms\_key\_id | The globally unique identifier for the EFS key. This output will be empty if the KMS key was passed as variable. |
| security\_group\_id | ID of the security group used for the EFS. This output will be empty if the security groups IDs were passed as variables. |
| security\_group\_rule\_ids | List of ID's of the security rules added to security group |
| ssm\_parameter\_arns | The ARNs of the SSM Parameters for the EFS. |
| ssm\_parameter\_names | The names of the SSM Parameters for the EFS. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
