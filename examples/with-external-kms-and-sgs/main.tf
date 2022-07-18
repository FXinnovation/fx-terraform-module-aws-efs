provider "aws" {
  region     = "eu-west-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "random_string" "this" {
  length  = 8
  upper   = false
  special = false
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# NOTE: This is a workaround https://github.com/terraform-providers/terraform-provider-aws/issues/7522
locals {
  subnet_ids_string = join(",", data.aws_subnets.default.ids)
  subnet_ids_list   = split(",", local.subnet_ids_string)
}

resource "aws_security_group" "with_external_kms_and_sgs" {
  name   = "tftest-${random_string.this.result}"
  vpc_id = data.aws_vpc.default.id
}

resource "aws_kms_key" "with_external_kms_and_sgs" {}

module "with_external_kms_and_sgs" {
  source = "../../"

  tags = {
    Name = "tftest"
  }

  subnet_ids = [element(local.subnet_ids_list, 0)]

  name = "tftest${random_string.this.result}"

  kms_key_arn        = aws_kms_key.with_external_kms_and_sgs.arn
  kms_key_alias_name = "alias/tftest/${random_string.this.result}"

  security_group_ids = [aws_security_group.with_external_kms_and_sgs.id]
}
