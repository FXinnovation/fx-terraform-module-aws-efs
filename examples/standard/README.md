# EFS module standard test

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money (AWS Elastic IP, for example). Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access\_key | Credentials: AWS access key. | string | n/a | yes |
| secret\_key | Credentials: AWS secret key. Pass this as a variable, never write password in the code. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| efs\_arn |  |
| efs\_dns\_name |  |
| efs\_id |  |
| efs\_mount\_target\_dns\_names |  |
| efs\_mount\_target\_ids |  |
| efs\_mount\_target\_network\_interface\_ids |  |
| kms\_alias\_arn |  |
| kms\_key\_arn |  |
| kms\_key\_id |  |
| security\_group\_id |  |
| ssm\_parameter\_arns |  |
| ssm\_parameter\_names |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
