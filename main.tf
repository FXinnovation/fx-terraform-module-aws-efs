#####
# EFS
#####

resource "aws_efs_file_system" "this" {
  count = "${var.enabled ? 1 : 0}"

  encrypted  = true
  kms_key_id = "${var.kms_key_arn != "" ? var.kms_key_arn : element(aws_kms_key.this.*.arn, 0)}"

  provisioned_throughput_in_mibps = "${var.provisioned_throughput_in_mibps}"
  performance_mode                = "${var.performance_mode}"
  throughput_mode                 = "${var.throughput_mode}"

  tags = "${merge(
    map("Terraform", "true"),
    map("Name", var.name),
    var.tags,
    var.efs_tags
  )}"
}

resource "aws_efs_mount_target" "this" {
  count = "${var.enabled && var.subnet_ids_count > 0 ? var.subnet_ids_count : 0}"

  file_system_id = "${aws_efs_file_system.this.id}"
  subnet_id      = "${element(var.subnet_ids, count.index)}"

  security_groups = ["${split(",", element(concat(var.security_group_ids, list("")), 0) != "" ? join(",", var.security_group_ids) : element(concat(aws_security_group.this.*.id, list("")), 0))}"]
}

#####
# KMS
#####

resource "aws_kms_key" "this" {
  count = "${var.enabled && var.kms_key_arn == "" ? 1 : 0}"

  description = "KMS Key for ${var.name} EFS encryption."

  tags = "${merge(
    map("Terraform", "true"),
    map("Name", var.kms_key_name),
    var.tags,
    var.kms_tags
  )}"
}

resource "aws_kms_alias" "this" {
  count = "${var.enabled && var.kms_key_arn == "" ? 1 : 0}"

  name          = "${var.kms_key_alias_name}"
  target_key_id = "${aws_kms_key.this.key_id}"
}

#####
# SSM Parameter
#####

resource "aws_ssm_parameter" "this_efs_id" {
  count = "${var.enabled && var.ssm_parameter_enabled ? 1 : 0}"

  name        = "${var.ssm_parameter_prefix}/efs/id"
  description = "ID of the ${var.name} EFS."
  type        = "String"
  value       = "${aws_efs_file_system.this.id}"
  overwrite   = true

  tags = "${merge(
    map("Terraform", "true"),
    var.tags,
    var.ssm_parameter_tags,
  )}"
}

#####
# Security group
#####

resource "aws_security_group" "this" {
  count = "${var.enabled && element(concat(var.security_group_ids, list("")), 0) != "" ? 1 : 0}"

  name        = "${var.security_group_name}"
  description = "Security group for ${var.name} EFS."
  vpc_id      = "${local.vpc_id}"

  tags = "${merge(
    map("Terraform", "true"),
    map("Name", var.security_group_name),
    var.tags,
    var.security_group_tags,
  )}"
}

resource "aws_security_group_rule" "this" {
  count = "${var.enabled && element(concat(var.security_group_ids, list("")), 0) != "" ? length(var.security_group_allowed_cidrs) : 0}"

  security_group_id = "${element(concat(aws_security_group.this.*.id, list("")), 0)}"

  type        = "ingress"
  from_port   = 2049
  to_port     = 2049
  protocol    = "tcp"
  description = "NFS from ${lookup(var.security_group_allowed_cidrs[count.index], "target")}."
  cidr_blocks = ["${lookup(var.security_group_allowed_cidrs[count.index], "cidr")}"]
}
