#####
# EFS
#####

resource "aws_efs_file_system" "this" {
  count = var.enabled ? 1 : 0

  encrypted  = true
  kms_key_id = var.enabled && var.kms_key_create ? element(concat(aws_kms_key.this.*.arn, [""]), 0) : var.kms_key_arn

  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
  performance_mode                = var.performance_mode
  throughput_mode                 = var.throughput_mode

  dynamic "lifecycle_policy" {
    for_each = var.lifecycle_policy

    content {
      transition_to_ia = lifecycle_policy.value
    }
  }

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
  count = var.enabled && length(var.subnet_ids) > 0 ? length(var.subnet_ids) : 0

  file_system_id = aws_efs_file_system.this[0].id
  subnet_id      = element(var.subnet_ids, count.index)

  security_groups = concat(aws_security_group.this.*.id, var.security_group_ids)
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
  count = var.enabled && (var.allowed_cidrs != [] || var.allowed_security_group_ids != []) ? 1 : 0

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

resource "aws_security_group_rule" "this_cidrs" {
  count = var.enabled && (var.allowed_cidrs != [] || var.allowed_security_group_ids != []) ? length(var.allowed_cidrs) : 0

  security_group_id = element(concat(aws_security_group.this.*.id, [
  ""]), 0)

  type        = "ingress"
  from_port   = 2049
  to_port     = 2049
  protocol    = "tcp"
  description = "NFS from ${element(var.allowed_cidrs, count.index)}."
  cidr_blocks = [
  var.allowed_cidrs[count.index]]
}

resource "aws_security_group_rule" "this_security_groups" {
  count = var.enabled && (var.allowed_cidrs != [] || var.allowed_security_group_ids != []) ? length(var.allowed_security_group_ids) : 0

  security_group_id = element(concat(aws_security_group.this.*.id, [
  ""]), 0)

  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  description              = "NFS from ${element(var.allowed_security_group_ids, count.index)}."
  source_security_group_id = var.allowed_security_group_ids[count.index]
}
