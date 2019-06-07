data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = "${data.aws_vpc.default.id}"
}

data "aws_subnet" "default" {
  id = "${element(concat(var.subnet_ids, list("")), 0) != "" ? element(var.subnet_ids, 0) : element(data.aws_subnet_ids.default.ids, 0)}"
}

locals {
  vpc_id = "${data.aws_subnet.default.vpc_id}"
}
