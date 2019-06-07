# Terraform EFS module

This module is not to be deployed directly.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| efs\_tags | Tags specific for the EFS. Will be merged with tags. | map | `{}` | no |
| enabled | Whether or not to enable this entire module or not. | string | `"true"` | no |
| kms\_key\_alias\_name | Name of the KMS key alias to be used to encrypt the EFS. | string | `"alias/efs"` | no |
| kms\_key\_arn | ARN of the KMS key to be used to encrypt the EFS. When not specified, this module will create a new KMS key. | string | `""` | no |
| kms\_key\_name | Name of the KMS key to be used to encrypt the EFS. | string | `"efs"` | no |
| kms\_tags | Tags specific for the KMS key for the EFS. Will be merged with tags. | map | `{}` | no |
| name | Name of the EFS. | string | `"efs"` | no |
| performance\_mode | The file system performance mode. Can be either ”generalPurpose” or “maxIO”. | string | `"generalPurpose"` | no |
| provisioned\_throughput\_in\_mibps | The throughput, measured in MiB/s, that you want to provision for the file system. Only applicable with throughput_mode set to “provisioned”. | string | `"0"` | no |
| security\_group\_allowed\_cidrs | CIDRs allowed to access the EFS. Must be a list of object containing “cidr” and “target” (the target of the CIDR). | list | `[ { "cidr": "10.0.0.0/8", "target": "all VPC" } ]` | no |
| security\_group\_ids | Security groups to be used by the EFS mount targets. If not specified, this module will create a new security group. | list | `[]` | no |
| security\_group\_name | Name of the security group to be used by the EFS mount targets. | string | `"efs"` | no |
| security\_group\_tags | Tags specific for the Security Group for the EFS mount targets. Will be merged with tags. | map | `{}` | no |
| ssm\_parameter\_enabled | Whether or not to create SSM Parameters containing EFS data. | string | `"false"` | no |
| ssm\_parameter\_prefix | Prefix for the SSM Parameters created by this module. It should an absolute path without trailing slash (e.g /my/example/path). | string | `"/efs/module/default"` | no |
| ssm\_parameter\_tags | Tags specific for the SSM Parameters for the EFS. Will be merged with tags. | map | `{}` | no |
| subnet\_ids | IDs of the subnet where the EFS should be made available. | list | `[]` | no |
| subnet\_ids\_count | Number of subnet IDs in var.subnet_ids. This value cannot be computed automatically in Terraform 0.11.X. | string | `"2"` | no |
| tags | Tags to be shared among all resources of this module. | map | `{}` | no |
| throughput\_mode | Throughput mode for the file system. Valid values: ”bursting”, “provisioned”. When using provisioned, also set provisioned_throughput_in_mibps. | string | `"bursting"` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
