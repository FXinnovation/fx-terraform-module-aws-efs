#####
# Module
#####

variable "enabled" {
  description = "Whether or not to enable this entire module or not."
  default     = true
}

variable "tags" {
  description = "Tags to be shared among all resources of this module."
  default     = {}
}

variable "subnet_ids" {
  description = "IDs of the subnet where the EFS should be made available. If none are specified, it will be deployed in the default vpc WITHOUT mount targets."
  default     = []
}

#####
# EFS
#####

variable "name" {
  description = "Name of the EFS."
  default     = "efs"
}

variable "performance_mode" {
  description = "The file system performance mode. Can be either ”generalPurpose” or “maxIO”."
  default     = "generalPurpose"
}

variable "provisioned_throughput_in_mibps" {
  description = "The throughput, measured in MiB/s, that you want to provision for the file system. Only applicable with throughput_mode set to “provisioned”."
  default     = 0
}

variable "throughput_mode" {
  description = "Throughput mode for the file system. Valid values: ”bursting”, “provisioned”. When using provisioned, also set provisioned_throughput_in_mibps."
  default     = "bursting"
}

variable "efs_tags" {
  description = "Tags specific for the EFS. Will be merged with tags."
  default     = {}
}

#####
# KMS
#####

variable "kms_key_arn" {
  description = "ARN of the KMS key to be used to encrypt the EFS. Should be specified when kms_ke_create is false."
  default     = null
  type        = string
}

variable "kms_key_alias_name" {
  description = "Name of the KMS key alias to be used to encrypt the EFS."
  default     = "alias/efs"
}

variable "kms_key_name" {
  description = "Name of the KMS key to be used to encrypt the EFS."
  default     = "efs"
}

variable "kms_tags" {
  description = "Tags specific for the KMS key for the EFS. Will be merged with tags."
  default     = {}
}

#####
# SSM Parameter
#####

variable "ssm_parameter_enabled" {
  description = "Whether or not to create SSM Parameters containing EFS data."
  default     = false
}

variable "ssm_parameter_prefix" {
  description = "Prefix for the SSM Parameters created by this module. It should an absolute path without trailing slash (e.g /my/example/path)."
  default     = "/efs/module/default"
}

variable "ssm_parameter_tags" {
  description = "Tags specific for the SSM Parameters for the EFS. Will be merged with tags."
  default     = {}
}

#####
# Security group
#####

variable "security_group_ids" {
  description = "List of additionnal security group IDs to be used by the EFS mount targets. MUST be specified when no `allowed_cidrs` or `allowed_security_group_ids` is provided."
  default     = []
}

variable "security_group_name" {
  description = "Name of the security group to be used by the EFS mount targets. Security group will be create ONLY IF `allowed_cidrs` or `allowed_security_group_ids` is NOT an empty list."
  default     = "efs"
}

variable "allowed_cidrs" {
  description = "CIDRs allowed to access the EFS. Must be a list of object containing “cidr” and “target” (the target of the CIDR)."
  default     = []
}

variable "allowed_security_group_ids" {
  description = "CIDRs allowed to access the EFS. Must be a list of object containing “cidr” and “target” (the target of the CIDR)."
  default     = []
}

variable "security_group_tags" {
  description = "Additionnal tags specific for the security group for the EFS mount targets. Will be merged with tags."
  default     = {}
}
