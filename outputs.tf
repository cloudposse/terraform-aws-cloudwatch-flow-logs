output "log_group_arn" {
  value       = "${join("", aws_cloudwatch_log_group.default.*.arn)}"
  description = "ARN of the log group"
}

output "vpc_flow_id" {
  value       = "${join("", aws_flow_log.vpc.*.id)}"
  description = "VPC Flow Log ID"
}

output "subnet_flow_ids" {
  value       = "${join("", aws_flow_log.subnets.*.id)}"
  description = "Flow Log IDs of subnets"
}

output "eni_flow_ids" {
  value       = "${join("", aws_flow_log.eni.*.id)}"
  description = "Flow Log IDs of ENIs"
}

output "kinesis_id" {
  value       = "${join("", aws_kinesis_stream.default.*.id)}"
  description = "Kinesis Stream ID"
}

output "kinesis_name" {
  value       = "${join("", aws_kinesis_stream.default.*.name)}"
  description = "Kinesis Stream name"
}

output "kinesis_shard_count" {
  value       = "${join("", aws_kinesis_stream.default.*.shard_count)}"
  description = "Kinesis Stream Shard count"
}

output "kinesis_arn" {
  value       = "${join("", aws_kinesis_stream.default.*.arn)}"
  description = "Kinesis Stream ARN"
}
