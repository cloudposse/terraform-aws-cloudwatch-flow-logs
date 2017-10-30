output "log_group_arn" {
  value       = "${aws_cloudwatch_log_group.default.arn}"
  description = "ARN of the log group"
}

output "kms_arn" {
  value       = "${aws_kms_key.default.arn}"
  description = "ARN of the key"
}

output "kms_key_id" {
  value       = "${aws_kms_key.default.key_id}"
  description = "The globally unique identifier for the key"
}

output "kinesis_id" {
  value       = "${aws_kinesis_stream.default.id}"
  description = "Stream ID"
}

output "kinesis_name" {
  value       = "${aws_kinesis_stream.default.name}"
  description = "Stream name"
}

output "kinesis_shard_count" {
  value       = "${aws_kinesis_stream.default.shard_count}"
  description = "Count of Shards for Stream"
}

output "kinesis_arn" {
  value       = "${aws_kinesis_stream.default.arn}"
  description = "ARN of Stream"
}

output "vpc_flow_ids" {
  value       = "${aws_flow_log.vpc.*.id}"
  description = "Flow Log IDs for vpcs"
}

output "vpc_subnets_ids" {
  value       = "${aws_flow_log.subnets.*.id}"
  description = "Flow Log IDs for subnets"
}

output "subscription_filter_arns" {
  value       = "${aws_cloudwatch_log_subscription_filter.default.*.arn}"
  description = "ARNs of the log subscription filters"
}

output "log_destination_arn" {
  value       = "${aws_cloudwatch_log_destination.default.id}"
  description = "ARN of the log destination"
}
