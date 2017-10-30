resource "aws_iam_role" "default" {
  name = "${module.vpc_label.id}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "default" {
  name = "${module.vpc_label.id}"
  role = "${aws_iam_role.default.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

###

resource "aws_iam_role" "kinesis" {
  name = "${module.kinesis_label.id}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "logs.${length(var.region) > 0 ? var.region: data.aws_region.default.name}.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "kinesis" {
  name = "${module.kinesis_label.id}"
  role = "${aws_iam_role.kinesis.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement" : [
    {
      "Action": [
        "kinesis:PutRecord*",
        "kinesis:DescribeStream",
        "kinesis:ListStreams"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_kinesis_stream.default.arn}"
      ]
    },
    {
      "Effect": "Allow",
      "Action": "iam:PassRole",
      "Resource": "${aws_iam_role.kinesis.arn}"
    }
  ]
}
EOF
}
