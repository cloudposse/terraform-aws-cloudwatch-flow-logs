output "log_group_arn" {
  value       = aws_cloudwatch_log_group.default[0].arn
  description = "ARN of the log group"
}

output "vpc_flow_id" {
  value       = aws_flow_log.vpc[0].id
  description = "Flow Log IDs of VPCs"
}

output "subnet_flow_ids" {
  value       = aws_flow_log.subnets.*.id
  description = "Flow Log IDs of subnets"
}

output "eni_flow_ids" {
  value       = aws_flow_log.eni.*.id
  description = "Flow Log IDs of ENIs"
}

output "kinesis_id" {
  value       = aws_kinesis_stream.default[0].id
  description = "Stream ID"
}

output "kinesis_name" {
  value       = aws_kinesis_stream.default[0].name
  description = "Stream name"
}

output "kinesis_shard_count" {
  value       = aws_kinesis_stream.default[0].shard_count
  description = "Count of Shards for Stream"
}

output "kinesis_arn" {
  value       = aws_kinesis_stream.default[0].arn
  description = "ARN of Stream"
}

