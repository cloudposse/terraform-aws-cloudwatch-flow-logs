variable "name" {
  default     = ""
  description = "Name  (e.g. `bastion` or `db`)"
}

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
  description = "AWS region"
  default     = ""
}

variable "retention_in_days" {
  description = "Number of days you want to retain log events in the log group"
  default     = "30"
}

variable "traffic_type" {
  description = "Type of traffic to capture. Valid values: ACCEPT,REJECT, ALL"
  default     = "ALL"
}

variable "vpc_id" {
  description = "ID of VPC"
}

variable "subnet_ids" {
  description = "IDs of subnets"
  type        = "list"
  default     = []
}

variable "eni_ids" {
  description = "IDs of ENIs"
  type        = "list"
  default     = []
}

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
  default     = "NONE"
}

variable "filter_pattern" {
  description = "Valid CloudWatch Logs filter pattern for subscribing to a filtered stream of log events"
  default     = "[version, account, eni, source, destination, srcport, destport, protocol, packets, bytes, windowstart, windowend, action, flowlogstatus]"
}

variable "kms_key_id" {
  description = "ID of KMS key"
  default     = ""
}

variable "enabled" {
  default     = "true"
  description = "Set to false to prevent the module from creating anything"
}
