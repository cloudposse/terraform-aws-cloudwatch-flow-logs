output "log_group_arn" {
  value       = "${aws_cloudwatch_log_group.default.arn}"
  description = "ARN of the log group"
}

output "vpc_flow_ids" {
  value       = "${aws_flow_log.vpc.*.id}"
  description = "Flow Log IDs for vpcs"
}

output "subnets_flow_ids" {
  value       = "${aws_flow_log.subnets.*.id}"
  description = "Flow Log IDs for subnets"
}
