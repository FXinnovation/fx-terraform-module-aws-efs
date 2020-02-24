# EFS module disabled test

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money (AWS Elastic IP, for example). Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| access\_key | Credentials: AWS access key. | `string` | n/a | yes |
| secret\_key | Credentials: AWS secret key. Pass this as a variable, never write password in the code. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| efs\_arn | n/a |
| efs\_dns\_name | n/a |
| efs\_id | n/a |
| efs\_mount\_target\_ids | n/a |
| efs\_mount\_target\_network\_interface\_ids | n/a |
| kms\_alias\_arn | n/a |
| kms\_key\_arn | n/a |
| kms\_key\_id | n/a |
| security\_group\_id | n/a |
| ssm\_parameter\_arns | n/a |
| ssm\_parameter\_names | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
