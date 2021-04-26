module "kinesis_label" {
  source  = "cloudposse/label/null"
  version = "0.24.1"

  context    = module.this.context
  attributes = ["kinesis"]
}

module "subscription_filter_label" {
  source  = "cloudposse/label/null"
  version = "0.24.1"

  context    = module.this.context
  attributes = ["filter"]
}

resource "aws_kinesis_stream" "default" {
  count               = module.this.enabled ? 1 : 0
  name                = module.kinesis_label.id
  shard_count         = var.shard_count
  retention_period    = var.retention_period
  shard_level_metrics = var.shard_level_metrics
  encryption_type     = var.encryption_type
  kms_key_id          = var.kms_key_id
  tags                = module.kinesis_label.tags
}

resource "aws_cloudwatch_log_subscription_filter" "default" {
  count           = module.this.enabled ? 1 : 0
  name            = module.subscription_filter_label.id
  log_group_name  = join("", aws_cloudwatch_log_group.default.*.name)
  filter_pattern  = var.filter_pattern
  destination_arn = join("", aws_kinesis_stream.default.*.arn)
  role_arn        = join("", aws_iam_role.kinesis.*.arn)
}
