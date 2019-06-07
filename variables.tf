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

//variable "vpc_id" {
//  description = "ID of the VPC where to create the EFS."
//  type        = "string"
//}

variable "subnet_ids_count" {
  description = "Number of subnet IDs in var.subnet_ids. This value cannot be computed automatically in Terraform 0.11.X."
  default     = 2
}

variable "subnet_ids" {
  description = "IDs of the subnet where the EFS should be made available."
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
  description = "ARN of the KMS key to be used to encrypt the EFS. When not specified, this module will create a new KMS key."
  default     = ""
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
  description = "Security groups to be used by the EFS mount targets. If not specified, this module will create a new security group."
  default     = []
}

variable "security_group_name" {
  description = "Name of the security group to be used by the EFS mount targets."
  default     = "efs"
}

variable "security_group_allowed_cidrs" {
  description = "CIDRs allowed to access the EFS. Must be a list of object containing “cidr” and “target” (the target of the CIDR)."

  default = [
    {
      cidr   = "10.0.0.0/8"
      target = "all VPC"
    },
  ]
}

variable "security_group_tags" {
  description = "Tags specific for the Security Group for the EFS mount targets. Will be merged with tags."
  default     = {}
}
