#####
# EFS
#####

resource "aws_efs_file_system" "this" {
  count = var.enabled ? 1 : 0

  encrypted  = true
  kms_key_id = var.kms_key_create ? element(concat(aws_kms_key.this.*.arn, [""]), 0) : var.kms_key_arn

  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
  performance_mode                = var.performance_mode
  throughput_mode                 = var.throughput_mode

  tags = merge(
    {
      "Terraform" = "true"
    },
    {
      "Name" = var.name
    },
    var.tags,
    var.efs_tags,
  )
}

resource "aws_efs_mount_target" "this" {
  count = var.enabled && var.subnet_ids_count > 0 ? var.subnet_ids_count : 0

  file_system_id = aws_efs_file_system.this[0].id
  subnet_id      = element(var.subnet_ids, count.index)

  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  security_groups = [var.security_group_create ? element(concat(aws_security_group.this.*.id, [""]), 0) : join(",", var.security_group_ids)]
}

#####
# KMS
#####

resource "aws_kms_key" "this" {
  count = var.enabled && var.kms_key_create ? 1 : 0

  description = "KMS Key for ${var.name} EFS encryption."

  tags = merge(
    {
      "Terraform" = "true"
    },
    {
      "Name" = var.kms_key_name
    },
    var.tags,
    var.kms_tags,
  )
}

resource "aws_kms_alias" "this" {
  count = var.enabled && var.kms_key_create ? 1 : 0

  name          = var.kms_key_alias_name
  target_key_id = aws_kms_key.this[0].key_id
}

#####
# SSM Parameter
#####

resource "aws_ssm_parameter" "this_efs_id" {
  count = var.enabled && var.ssm_parameter_enabled ? 1 : 0

  name        = "${var.ssm_parameter_prefix}/efs/id"
  description = "ID of the ${var.name} EFS."
  type        = "String"
  value       = aws_efs_file_system.this[0].id
  overwrite   = true

  tags = merge(
    {
      "Terraform" = "true"
    },
    var.tags,
    var.ssm_parameter_tags,
  )
}

#####
# Security group
#####

resource "aws_security_group" "this" {
  count = var.enabled && var.security_group_create ? 1 : 0

  name        = var.security_group_name
  description = "Security group for ${var.name} EFS."
  vpc_id      = local.vpc_id

  tags = merge(
    {
      "Terraform" = "true"
    },
    {
      "Name" = var.security_group_name
    },
    var.tags,
    var.security_group_tags,
  )
}

resource "aws_security_group_rule" "this" {
  count = var.enabled && var.security_group_create ? length(var.security_group_allowed_cidrs) : 0

  security_group_id = element(concat(aws_security_group.this.*.id, [""]), 0)

  type        = "ingress"
  from_port   = 2049
  to_port     = 2049
  protocol    = "tcp"
  description = "NFS from ${var.security_group_allowed_cidrs[count.index]["target"]}."
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  cidr_blocks = [var.security_group_allowed_cidrs[count.index]["cidr"]]
}
