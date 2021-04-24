output "public_subnet_cidrs" {
  value = module.subnets.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  value = module.subnets.private_subnet_cidrs
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr_block
}

output "kinesis_shard_count" {
  value = module.flow_logs.kinesis_shard_count
}

output "log_group_arn" {
  value = module.flow_logs.log_group_arn
}

output "vpc_flow_id" {
  value = module.flow_logs.vpc_flow_id
}