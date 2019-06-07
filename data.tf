data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = "${data.aws_vpc.default.id}"
}

data "aws_subnet" "default" {
  id = "${element(concat(var.subnet_ids, list("")), 0) != "" ? element(concat(var.subnet_ids, list("")), 0) : element(concat(data.aws_subnet_ids.default.ids, list("")), 0)}"
}

locals {
  vpc_id = "${data.aws_subnet.default.vpc_id}"
}
