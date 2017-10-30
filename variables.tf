variable "namespace" {
  description = "Namespace (e.g. `cp` or `cloudposse`)"
  type        = "string"
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  type        = "string"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `policy` or `role`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "region" {
  default = ""
}

variable "retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group"
  default     = "30"
}

variable "kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data"
  default     = ""
}

variable "traffic_type" {
  description = "The type of traffic to capture. Valid values: ACCEPT,REJECT, ALL"
  default     = "ALL"
}

variable "description" {
  description = "The description of the key as viewed in AWS console"
  default     = "Managed by Terraform"
}

variable "deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days"
  default     = "30"
}

variable "key_usage" {
  description = "Specifies the intended use of the key. Only symmetric encryption and decryption are supported"
  default     = "ENCRYPT_DECRYPT"
}

variable "policy" {
  description = "KMS policy in JSON format"
  default     = ""
}

variable "is_enabled" {
  description = "Specifies whether the key is enabled"
  default     = "true"
}

variable "enable_key_rotation" {
  description = "Specifies whether key rotation is enabled"
  default     = "false"
}

variable "vpc_id" {
  description = "ID of VPC"
}

# variable "subnets_ids" {
#   description = "ID of subnets"
#   default     = []
# }

variable "shard_count" {
  description = "Number of shards that the stream will use"
  default     = "1"
}

variable "retention_period" {
  description = "Length of time data records are accessible after they are added to the stream"
  default     = "48"
}

variable "shard_level_metrics" {
  description = "List of shard-level CloudWatch metrics which can be enabled for the stream"

  default = [
    "IncomingBytes",
    "OutgoingBytes",
  ]
}

variable "encryption_type" {
  description = "GUID for the customer-managed KMS key to use for encryption. The only acceptable values are NONE or KMS"
  default     = "KMS"
}

variable "filter_patterns" {
  description = " Valid CloudWatch Logs filter pattern for subscribing to a filtered stream of log events"
  default     = []
}
