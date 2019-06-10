#####
# EFS
#####

output "efs_arn" {
  value = "${module.with_external_kms_and_sgs.efs_arn}"
}

output "efs_id" {
  value = "${module.with_external_kms_and_sgs.efs_id}"
}

output "efs_dns_name" {
  value = "${module.with_external_kms_and_sgs.efs_dns_name}"
}

output "efs_mount_target_network_interface_ids" {
  value = "${module.with_external_kms_and_sgs.efs_mount_target_network_interface_ids}"
}

output "efs_mount_target_ids" {
  value = "${module.with_external_kms_and_sgs.efs_mount_target_ids}"
}

#####
# KMS
#####

output "kms_key_id" {
  value = "${module.with_external_kms_and_sgs.kms_key_id}"
}

output "kms_key_arn" {
  value = "${module.with_external_kms_and_sgs.kms_key_arn}"
}

output "kms_alias_arn" {
  value = "${module.with_external_kms_and_sgs.kms_alias_arn}"
}

#####
# SSM Parameter
#####

output "ssm_parameter_arns" {
  value = "${module.with_external_kms_and_sgs.ssm_parameter_arns}"
}

output "ssm_parameter_names" {
  value = "${module.with_external_kms_and_sgs.ssm_parameter_names}"
}

#####
# Security group
#####

output "security_group_id" {
  value = "${module.with_external_kms_and_sgs.security_group_id}"
}
