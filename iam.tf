data "aws_iam_policy_document" "log_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "log" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role_policy" "log" {
  name   = "${module.vpc_label.id}"
  role   = "${aws_iam_role.log.id}"
  policy = "${data.aws_iam_policy_document.log.json}"
}

resource "aws_iam_role" "log" {
  name               = "${module.vpc_label.id}"
  assume_role_policy = "${data.aws_iam_policy_document.log_assume.json}"
}

data "aws_iam_policy_document" "kinesis_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["logs.${length(var.region) > 0 ? var.region: data.aws_region.default.name}.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "kinesis" {
  statement {
    actions = [
      "kinesis:PutRecord*",
      "kinesis:DescribeStream",
      "kinesis:ListStreams",
    ]

    resources = [
      "${aws_kinesis_stream.default.arn}",
    ]
  }
}

resource "aws_iam_role" "kinesis" {
  name               = "${module.kinesis_label.id}"
  assume_role_policy = "${data.aws_iam_policy_document.kinesis_assume.json}"
}

resource "aws_iam_role_policy" "kinesis" {
  name   = "${module.vpc_label.id}"
  role   = "${aws_iam_role.kinesis.id}"
  policy = "${data.aws_iam_policy_document.kinesis.json}"
}
