provider "aws" {
  version    = "~> 2.2.0"
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

resource "aws_security_group" "with_external_kms_and_sgs" {
  name   = "tftest-${random_string.this.result}"
  vpc_id = "${data.aws_vpc.default.id}"
}

resource "aws_kms_key" "with_external_kms_and_sgs" {}

module "with_external_kms_and_sgs" {
  source = "../../"

  tags = {
    Name = "tftest"
  }

  subnet_ids_count = 1
  subnet_ids       = ["${element(data.aws_subnet_ids.default.ids, 0)}"]

  name = "tftest${random_string.this.result}"

  kms_key_arn = "${aws_kms_key.with_external_kms_and_sgs.arn}"

  security_group_ids = ["${aws_security_group.with_external_kms_and_sgs.id}"]
}
