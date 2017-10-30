data "aws_region" "default" {
  current = true
}

data "aws_subnet_ids" "default" {
  vpc_id = "${var.vpc_id}"
}

module "log_group_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.2.2"
  namespace  = "${var.namespace}"
  name       = "logs"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
}

module "kms_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.2.2"
  namespace  = "${var.namespace}"
  name       = "kms"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
}

module "vpc_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.2.2"
  namespace  = "${var.namespace}"
  name       = "vpc"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
}

module "subnet_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.2.2"
  namespace  = "${var.namespace}"
  name       = "subnet"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
}

module "kinesis_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.2.2"
  namespace  = "${var.namespace}"
  name       = "kinesis"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
}

resource "aws_kms_key" "default" {
  description             = "${module.kms_label.id} ${var.description}"
  deletion_window_in_days = "${var.deletion_window_in_days}"
  key_usage               = "${var.key_usage}"
  policy                  = "${var.policy}"
  is_enabled              = "${var.is_enabled}"
  enable_key_rotation     = "${var.enable_key_rotation}"
  tags                    = "${module.kms_label.tags}"
}

resource "aws_cloudwatch_log_group" "default" {
  name              = "${module.log_group_label.id}"
  retention_in_days = "${var.retention_in_days}"
  kms_key_id        = "${aws_kms_key.default.key_id}"
  tags              = "${module.log_group_label.tags}"
}

resource "aws_kinesis_stream" "default" {
  name                = "${module.kinesis_label.id}"
  shard_count         = "${var.shard_count}"
  retention_period    = "${var.retention_period}"
  shard_level_metrics = "${var.shard_level_metrics}"
  encryption_type     = "${var.encryption_type}"
  kms_key_id          = "${var.encryption_type != "NONE" ? aws_kms_key.default.key_id : ""}"
  tags                = "${module.kinesis_label.tags}"
}

resource "aws_flow_log" "vpc" {
  log_group_name = "${aws_cloudwatch_log_group.default.name}"
  iam_role_arn   = "${aws_iam_role.default.arn}"
  vpc_id         = "${var.vpc_id[count.index]}"
  traffic_type   = "${var.traffic_type}"
}

resource "aws_flow_log" "subnets" {
  count          = "${length(data.aws_subnet_ids.default.ids)}"
  log_group_name = "${aws_cloudwatch_log_group.default.name}"
  iam_role_arn   = "${aws_iam_role.default.arn}"
  subnet_id      = "${data.aws_subnet_ids.default.ids[count.index]}"
  traffic_type   = "${var.traffic_type}"
}

resource "aws_cloudwatch_log_subscription_filter" "default" {
  count           = "${length(var.filter_patterns)}"
  name            = "${aws_cloudwatch_log_group.default.name}"
  log_group_name  = "${aws_cloudwatch_log_group.default.name}"
  filter_pattern  = "${var.filter_patterns[count.index]}"
  destination_arn = "${aws_kinesis_stream.default.arn}"
  role_arn        = "${aws_iam_role.kinesis.arn}"
}

resource "aws_cloudwatch_log_destination" "default" {
  name       = "${aws_kinesis_stream.default.name}"
  role_arn   = "${aws_iam_role.kinesis.arn}"
  target_arn = "${aws_kinesis_stream.default.arn}"
}
