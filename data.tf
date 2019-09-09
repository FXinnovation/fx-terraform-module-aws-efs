data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

# NOTE: This is a workaround https://github.com/terraform-providers/terraform-provider-aws/issues/7522
locals {
  subnet_ids_string = join(",", data.aws_subnet_ids.default.ids)
  subnet_ids_list   = split(",", local.subnet_ids_string)
}


data "aws_subnet" "default" {
  id = length(var.subnet_ids == 0) ? element(concat(var.subnet_ids, list("")), 0) : element(concat(local.subnet_ids_list, list("")), 0)
}

locals {
  vpc_id = data.aws_subnet.default.vpc_id
}
