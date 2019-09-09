provider "aws" {
  version    = "> 2.7.0"
  region     = "eu-west-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

resource "random_string" "this" {
  length  = 8
  upper   = false
  special = false
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = "${data.aws_vpc.default.id}"
}

module "standard" {
  source = "../../"

  tags = {
    Name = "tftest"
  }

  subnet_ids_count = "${length(data.aws_subnet_ids.default.ids)}"
  subnet_ids       = "${data.aws_subnet_ids.default.ids}"

  name = "tftest${random_string.this.result}"

  kms_key_alias_name = "alias/tftest/${random_string.this.result}"
  kms_key_name       = "tftest${random_string.this.result}"

  ssm_parameter_enabled = true
  ssm_parameter_prefix  = "/param/tftest${random_string.this.result}"
}