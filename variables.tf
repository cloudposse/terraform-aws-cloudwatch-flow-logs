variable "region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "retention_in_days" {
  description = "Number of days you want to retain log events in the log group"
  type        = number
  default     = 30
}

variable "traffic_type" {
  description = "Type of traffic to capture. Valid values: ACCEPT,REJECT, ALL"
  type        = string
  default     = "ALL"
}

variable "vpc_id" {
  description = "ID of VPC"
  type        = string
}

variable "subnet_ids" {
  description = "IDs of subnets"
  type        = list(string)
  default     = []
}

variable "eni_ids" {
  description = "IDs of ENIs"
  type        = list(string)
  default     = []
}

variable "shard_count" {
  description = "Number of shards that the stream will use"
  type        = number
  default     = 1
}

variable "retention_period" {
  description = "Length of time data records are accessible after they are added to the stream"
  type        = number
  default     = 48
}

variable "shard_level_metrics" {
  description = "List of shard-level CloudWatch metrics which can be enabled for the stream"
  type        = list(string)

  default = [
    "IncomingBytes",
    "OutgoingBytes",
  ]
}

variable "encryption_type" {
  description = "GUID for the customer-managed KMS key to use for encryption. The only acceptable values are NONE or KMS"
  type        = string
  default     = "NONE"
}

variable "filter_pattern" {
  description = "Valid CloudWatch Logs filter pattern for subscribing to a filtered stream of log events"
  default     = "[version, account, eni, source, destination, srcport, destport, protocol, packets, bytes, windowstart, windowend, action, flowlogstatus]"
}

variable "kms_key_id" {
  description = "ID of KMS key to encrypt Kinesis"
  type        = string
  default     = ""
}

variable "log_group_kms_key_arn" {
  description = "The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested."
  default     = ""
}
