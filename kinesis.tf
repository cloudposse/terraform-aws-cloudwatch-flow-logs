module "kinesis_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.3.1"
  namespace  = "${var.namespace}"
  name       = "${var.name}"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${compact(concat(var.attributes, list("kinesis")))}"
  tags       = "${var.tags}"
  enabled    = "${var.enabled}"
}

module "subscription_filter_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.3.1"
  namespace  = "${var.namespace}"
  name       = "${var.name}"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${compact(concat(var.attributes, list("filter")))}"
  tags       = "${var.tags}"
  enabled    = "${var.enabled}"
}

resource "aws_kinesis_stream" "default" {
  count               = "${var.enabled == "true" ? 1 : 0}"
  name                = "${module.kinesis_label.id}"
  shard_count         = "${var.shard_count}"
  retention_period    = "${var.retention_period}"
  shard_level_metrics = "${var.shard_level_metrics}"
  encryption_type     = "${var.encryption_type}"
  kms_key_id          = "${var.kms_key_id}"
  tags                = "${module.kinesis_label.tags}"
}

resource "aws_cloudwatch_log_subscription_filter" "default" {
  count           = "${var.enabled == "true" ? 1 : 0}"
  name            = "${module.subscription_filter_label.id}"
  log_group_name  = "${aws_cloudwatch_log_group.default.name}"
  filter_pattern  = "${var.filter_pattern}"
  destination_arn = "${aws_kinesis_stream.default.arn}"
  role_arn        = "${aws_iam_role.kinesis.arn}"
}
