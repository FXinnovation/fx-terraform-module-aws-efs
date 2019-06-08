#####
# EFS
#####

output "efs_arn" {
  description = "Amazon Resource Name of the file system."
  value       = "${element(concat(aws_efs_file_system.this.*.arn, list("")), 0)}"
}

output "efs_id" {
  description = "The ID that identifies the file system (e.g. fs-ccfc0d65)."
  value       = "${element(concat(aws_efs_file_system.this.*.id, list("")), 0)}"
}

output "efs_dns_name" {
  description = "The DNS name for the filesystem."
  value       = "${element(concat(aws_efs_file_system.this.*.dns_name, list("")), 0)}"
}

output "efs_mount_target_network_interface_ids" {
  description = "The IDs of the network interfaces that Amazon EFS created when it created the mount targets."
  value       = "${aws_efs_mount_target.this.*.network_interface_id}"
}

output "efs_mount_target_ids" {
  description = "The IDs of the EFS mount targets."
  value       = "${aws_efs_mount_target.this.*.id}"
}

#####
# KMS
#####

output "kms_key_id" {
  description = "The globally unique identifier for the EFS key. This output will be empty if the KMS key was passed as variable."
  value       = "${element(concat(aws_kms_key.this.*.id, list("")), 0)}"
}

output "kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the EFS key. This output will be empty if the KMS key was passed as variable."
  value       = "${element(concat(aws_kms_key.this.*.arn, list("")), 0)}"
}

output "kms_alias_arn" {
  description = "The Amazon Resource Name (ARN) of the EFS key alias. This output will be empty if the KMS key was passed as variable."
  value       = "${element(concat(aws_kms_alias.this.*.arn, list("")), 0)}"
}

#####
# SSM Parameter
#####

output "ssm_parameter_arns" {
  description = "The ARNs of the SSM Parameters for the EFS."
  value       = ["${element(concat(aws_ssm_parameter.this_efs_id.*.arn, list("")), 0)}"]
}

output "ssm_parameter_names" {
  description = "The names of the SSM Parameters for the EFS."
  value       = ["${element(concat(aws_ssm_parameter.this_efs_id.*.name, list("")), 0)}"]
}

#####
# Security group
#####

output "security_group_id" {
  description = "ID of the security group used for the EFS. This output will be empty if the security groups IDs were passed as variables."
  value       = "${element(concat(aws_security_group.this.*.id, list("")), 0)}"
}
