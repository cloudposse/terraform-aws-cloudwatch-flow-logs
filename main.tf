data "aws_region" "default" {}

module "log_group_label" {
  source  = "cloudposse/label/null"
  version = "0.24.1"

  context    = module.this.context
  attributes = ["log"]
}

module "vpc_label" {
  source  = "cloudposse/label/null"
  version = "0.24.1"

  context    = module.this.context
  attributes = ["vpc"]
}

module "subnet_label" {
  source  = "cloudposse/label/null"
  version = "0.24.1"

  context    = module.this.context
  attributes = ["subnets"]
}

resource "aws_cloudwatch_log_group" "default" {
  count             = module.this.enabled ? 1 : 0
  name              = module.log_group_label.id
  retention_in_days = var.retention_in_days
  kms_key_id        = var.log_group_kms_key_arn
  tags              = module.log_group_label.tags
}

resource "aws_flow_log" "vpc" {
  count           = module.this.enabled ? 1 : 0
  log_destination = join("", aws_cloudwatch_log_group.default.*.arn)
  iam_role_arn    = join("", aws_iam_role.log.*.arn)
  vpc_id          = var.vpc_id
  traffic_type    = var.traffic_type
}

resource "aws_flow_log" "subnets" {
  count           = module.this.enabled ? length(compact(var.subnet_ids)) : 0
  log_destination = join("", aws_cloudwatch_log_group.default.*.arn)
  iam_role_arn    = join("", aws_iam_role.log.*.arn)
  subnet_id       = element(compact(var.subnet_ids), count.index)
  traffic_type    = var.traffic_type
}

resource "aws_flow_log" "eni" {
  count           = module.this.enabled ? length(compact(var.eni_ids)) : 0
  log_destination = join("", aws_cloudwatch_log_group.default.*.arn)
  iam_role_arn    = join("", aws_iam_role.log.*.arn)
  subnet_id       = element(compact(var.eni_ids), count.index)
  traffic_type    = var.traffic_type
}
