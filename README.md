# terraform-aws-cloudwatch-flow-logs [![Build Status](https://travis-ci.org/cloudposse/terraform-aws-cloudwatch-flow-logs.svg)](https://travis-ci.org/cloudposse/terraform-aws-cloudwatch-flow-logs)

Terraform module for enabling [`flow logs`](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/flow-logs.html) for `vpc` and `subnets`.

## Usage

```terraform
module "flow_logs" {
  source    = "git::https://github.com/cloudposse/terraform-aws-cloudwatch-flow-logs.git?ref=master"
  vpc_id    = "${var.vpc_id}"
  namespace = "${var.namespace}"
  stage     = "${var.stage}"
}
```
## Inputs

| Name                  |                Default                 | Description                                                                                             | Required |
|:----------------------|:--------------------------------------:|:--------------------------------------------------------------------------------------------------------|:--------:|
| `namespace`           |                   ``                   | Namespace (e.g. `cp` or `cloudposse`)                                                                   |   Yes    |
| `stage`               |                   ``                   | Stage (e.g. `prod`, `dev`, `staging`)                                                                   |   Yes    |
| `name`                |                   ``                   | Name  (e.g. `bastion` or `db`)                                                                          |    No    |
| `delimiter`           |                  `-`                   | Delimiter to be used between `name`, `namespace`, `stage`, etc.                                         |    No    |
| `attributes`          |                  `[]`                  | Additional attributes (e.g. `policy` or `role`)                                                         |    No    |
| `tags`                |                  `{}`                  | Additional tags  (e.g. `map("BusinessUnit","XYZ")`                                                      |    No    |
| `vpc_id`              |                   ``                   | ID of VPC                                                                                               |   Yes    |
| `subnet_ids`          |                  `[]`                  | IDs of subnets                                                                                          |   Yes    |
| `eni_ids`             |                  `[]`                  | IDs of ENIs                                                                                             |   Yes    |
| `region`              |                   ``                   | AWS region e.g. `us-central-1`                                                                          |    No    |
| `retention_in_days`   |                  `30`                  | Number of days you want to retain log events in the log group                                           |    No    |
| `traffic_type`        |                 `ALL`                  | Type of traffic to capture. Valid values: ACCEPT,REJECT, ALL                                            |    No    |
| `shard_count`         |                  `1`                   | Number of shards that the stream will use                                                               |    No    |
| `retention_period`    |                  `48`                  | Length of time data records are accessible after they are added to the stream                           |    No    |
| `shard_level_metrics` | `[ "IncomingBytes", "OutgoingBytes",]` | List of shard-level CloudWatch metrics which can be enabled for the stream                              |    No    |
| `encryption_type`     |                 `NONE`                 | GUID for the customer-managed KMS key to use for encryption. The only acceptable values are NONE or KMS |    No    |
| `filter_pattern`      |                 `"[]"`                 | Valid CloudWatch Logs filter pattern for subscribing to a filtered stream of log events                 |    No    |




## Outputs

| Name                       | Description                          |
|:---------------------------|:-------------------------------------|
| `log_group_arn`            | ARN of the log group                 |
| `eni_flow_ids`             | Flow Log IDs of ENIs                 |
| `subnet_flow_ids`          | Flow Log IDs of subnets              |
| `vpc_flow_id`              | Flow Log IDs of VPC                  |
| `kinesis_arn`              | ARN of Stream                        |
| `kinesis_id`               | Stream ID                            |
| `kinesis_name`             | Stream name                          |
| `kinesis_shard_count`      | Count of Shards for Stream           |
| `subscription_filter_arns` | ARNs of the log subscription filters |

## License

Apache 2 License. See [`LICENSE`](LICENSE) for full details.
