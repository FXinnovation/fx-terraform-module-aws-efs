#####
# EFS
#####

output "efs_arn" {
  value = "${module.disabled.efs_arn}"
}

output "efs_id" {
  value = "${module.disabled.efs_id}"
}

output "efs_dns_name" {
  value = "${module.disabled.efs_dns_name}"
}

output "efs_mount_target_network_interface_ids" {
  value = "${module.disabled.efs_mount_target_network_interface_ids}"
}

output "efs_mount_target_ids" {
  value = "${module.disabled.efs_mount_target_ids}"
}

output "efs_mount_target_dns_names" {
  value = "${module.disabled.efs_mount_target_dns_names}"
}

#####
# KMS
#####

output "kms_key_id" {
  value = "${module.disabled.kms_key_id}"
}

output "kms_key_arn" {
  value = "${module.disabled.kms_key_arn}"
}

output "kms_alias_arn" {
  value = "${module.disabled.kms_alias_arn}"
}

#####
# SSM Parameter
#####

output "ssm_parameter_arns" {
  value = "${module.disabled.ssm_parameter_arns}"
}

output "ssm_parameter_names" {
  value = "${module.disabled.ssm_parameter_names}"
}

#####
# Security group
#####

output "security_group_id" {
  value = "${module.disabled.security_group_id}"
}
