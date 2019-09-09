provider "aws" {
  version    = "> 2.7.0"
  region     = "eu-west-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "disabled" {
  source = "../../"

  tags = {
    Name = "tftest"
  }

  enabled = false
}