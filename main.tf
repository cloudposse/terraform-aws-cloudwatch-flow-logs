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

resource "aws_cloudwatch_log_group" "default" {
  name              = "${module.log_group_label.id}"
  retention_in_days = "${var.retention_in_days}"
  tags              = "${module.log_group_label.tags}"
}

resource "aws_flow_log" "vpc" {
  log_group_name = "${aws_cloudwatch_log_group.default.name}"
  iam_role_arn   = "${aws_iam_role.log.arn}"
  vpc_id         = "${var.vpc_id}"
  traffic_type   = "${var.traffic_type}"
}

resource "aws_flow_log" "subnets" {
  count          = "${length(data.aws_subnet_ids.default.ids)}"
  log_group_name = "${aws_cloudwatch_log_group.default.name}"
  iam_role_arn   = "${aws_iam_role.log.arn}"
  subnet_id      = "${element(data.aws_subnet_ids.default.ids, count.index)}"
  traffic_type   = "${var.traffic_type}"
}
