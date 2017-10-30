resource "aws_kinesis_stream" "default" {
  name                = "${module.kinesis_label.id}"
  shard_count         = "${var.shard_count}"
  retention_period    = "${var.retention_period}"
  shard_level_metrics = "${var.shard_level_metrics}"
  encryption_type     = "${var.encryption_type}"

  #kms_key_id          = "${var.encryption_type != "NONE" ? aws_kms_key.default.key_id : ""}"
  tags = "${module.kinesis_label.tags}"
}

resource "aws_cloudwatch_log_subscription_filter" "default" {
  name            = "${aws_cloudwatch_log_group.default.name}"
  log_group_name  = "${aws_cloudwatch_log_group.default.name}"
  filter_pattern  = "${var.filter_pattern}"
  destination_arn = "${aws_kinesis_stream.default.arn}"
  role_arn        = "${aws_iam_role.kinesis.arn}"
}
