data "aws_region" "default" {
  current = "true"
}

module "log_group_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.3.1"
  namespace  = "${var.namespace}"
  name       = "${var.name}"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${compact(concat(var.attributes, list("log")))}"
  tags       = "${var.tags}"
  enabled    = "${var.enabled}"
}

module "vpc_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.3.1"
  namespace  = "${var.namespace}"
  name       = "${var.name}"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${compact(concat(var.attributes, list("vpc")))}"
  tags       = "${var.tags}"
  enabled    = "${var.enabled}"
}

module "subnet_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.3.1"
  namespace  = "${var.namespace}"
  name       = "${var.name}"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${compact(concat(var.attributes, list("subnets")))}"
  tags       = "${var.tags}"
  enabled    = "${var.enabled}"
}

resource "aws_cloudwatch_log_group" "default" {
  count             = "${var.enabled == "true" ? 1 : 0}"
  name              = "${module.log_group_label.id}"
  retention_in_days = "${var.retention_in_days}"
  tags              = "${module.log_group_label.tags}"
}

resource "aws_flow_log" "vpc" {
  count          = "${var.enabled == "true" ? 1 : 0}"
  log_group_name = "${aws_cloudwatch_log_group.default.name}"
  iam_role_arn   = "${aws_iam_role.log.arn}"
  vpc_id         = "${var.vpc_id}"
  traffic_type   = "${var.traffic_type}"
}

resource "aws_flow_log" "subnets" {
  count          = "${var.enabled == "true" ? length(compact(var.subnet_ids)) : 0}"
  log_group_name = "${aws_cloudwatch_log_group.default.name}"
  iam_role_arn   = "${aws_iam_role.log.arn}"
  subnet_id      = "${element(compact(var.subnet_ids), count.index)}"
  traffic_type   = "${var.traffic_type}"
}

resource "aws_flow_log" "eni" {
  count          = "${var.enabled == "true" ? length(compact(var.eni_ids)) : 0}"
  log_group_name = "${aws_cloudwatch_log_group.default.name}"
  iam_role_arn   = "${aws_iam_role.log.arn}"
  subnet_id      = "${element(compact(var.eni_ids), count.index)}"
  traffic_type   = "${var.traffic_type}"
}
