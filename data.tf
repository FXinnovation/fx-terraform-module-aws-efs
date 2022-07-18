data "aws_vpc" "default" {
  count = 0 == length(var.subnet_ids) ? 1 : 0

  default = true
}

data "aws_subnets" "default" {
  count = 0 == length(var.subnet_ids) ? 1 : 0

  filter {
    name   = "vpc-id"
    values = [element(concat(data.aws_vpc.default.*.id, [""]), 0)]
  }
}

data "aws_subnet" "default" {
  id = 0 == length(var.subnet_ids) ? element(concat(local.subnet_ids_list, []), 0) : element(concat(var.subnet_ids, [""]), 0)
}

locals {
  subnet_ids_string = 0 == length(var.subnet_ids) ? join(",", element(concat(tolist(data.aws_subnets.default[0].ids), [""]), 0)) : ""
  subnet_ids_list   = split(",", local.subnet_ids_string)
  vpc_id            = data.aws_subnet.default.vpc_id
}
