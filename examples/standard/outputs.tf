#####
# EFS
#####

output "efs_arn" {
  value = module.standard.efs_arn
}

output "efs_id" {
  value = module.standard.efs_id
}

output "efs_dns_name" {
  value = module.standard.efs_dns_name
}

output "efs_mount_target_network_interface_ids" {
  value = module.standard.efs_mount_target_network_interface_ids
}

output "efs_mount_target_ids" {
  value = module.standard.efs_mount_target_ids
}

#####
# KMS
#####

output "kms_key_id" {
  value = module.standard.kms_key_id
}

output "kms_key_arn" {
  value = module.standard.kms_key_arn
}

output "kms_alias_arn" {
  value = module.standard.kms_alias_arn
}

#####
# SSM Parameter
#####

output "ssm_parameter_arns" {
  value = module.standard.ssm_parameter_arns
}

output "ssm_parameter_names" {
  value = module.standard.ssm_parameter_names
}

#####
# Security group
#####

output "security_group_id" {
  value = module.standard.security_group_id
}
