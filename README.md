#terraform-aws-cloudwatch-logs

Terraform module for enabling flow logs for vpc, sudnets.

## Usage

module "flow_logs" {
  source = "git::https://github.com/cloudposse/terraform-aws-cloudwatch-logs.git?ref=master"
  vpc_id = "vpc-d309abab"
  namespace = "cp"
  stage     = "dev"
}

## Inputs

| Name                | Default | Description                                                     | Required |
|:--------------------|:-------:|:----------------------------------------------------------------|:--------:|
| `namespace`         |   ``    | Namespace (e.g. `cp` or `cloudposse`)                           |   Yes    |
| `stage`             |   ``    | Stage (e.g. `prod`, `dev`, `staging`)                           |   Yes    |
| `delimiter`         |   `-`   | Delimiter to be used between `name`, `namespace`, `stage`, etc. |    No    |
| `attributes`        |  `[]`   | Additional attributes (e.g. `policy` or `role`)                 |    No    |
| `tags`              |  `{}`   | Additional tags  (e.g. `map("BusinessUnit","XYZ")`              |    No    |
| `vpc_id`            |   ``    | ID of VPC                                                       |   Yes    |
| `region`            |   ``    | AWS region e.g. `us-central-1`                                  |    No    |
| `retention_in_days` |  `30`   | Number of days you want to retain log events in the log group   |    No    |
| `traffic_type`      |  `ALL`  | Type of traffic to capture. Valid values: ACCEPT,REJECT, ALL    |    No    |


## Outputs

| Name             | Description              |
|:-----------------|:-------------------------|
| log_group_arn    | ARN of the log group     |
| subnets_flow_ids | Flow Log IDs for subnets |
| vpc_flow_ids     | Flow Log IDs for vpcs    |

## License

Apache 2 License. See [`LICENSE`](LICENSE) for full details.
