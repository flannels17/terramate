# OpenSearch

## Cost

| Parameters            | Option 1 | Option 2 | Option 2 | Option 4 |
| --------------------- | -------- | -------- | -------- | -------- |
| Hot storage number    | 1        | 3        | 3        | 3        |
| Dedicate Master Nodes | 0        | 0        | 3        | 3        |
| Warm storage          | 0        | 0        | 0        | 2        |
| Total Costs           | $126,21  | $349.59  | $684,66  | $1156,33 |

All options are using the "m6g.large.search" instance type and an ebs volume of 100 GB.

The instance type for warm storage is "ultrawarm1.large.search" with 10% usage per month and 100 GB of storage.

Cold storage cost $2.6 per 100 GB.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.47.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.opensearch_log_group_audit_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.opensearch_log_group_es_application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.opensearch_log_group_index_slow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.opensearch_log_group_search_slow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_resource_policy.opensearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_cloudwatch_metric_alarm.oss_clusterstatus_metric](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.oss_cpu_metric](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.oss_freestorage_metric](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.oss_http_metric](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.oss_jvmmem_metric](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_iam_role.es-loader-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_service_linked_role.opensearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_opensearch_domain.cf_opensearch_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain) | resource |
| [aws_opensearch_domain_saml_options.opensearch_saml](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain_saml_options) | resource |
| [aws_security_group.es-loader-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.vpc_enabled](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.https_access_allowed_cidrs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.https_access_es_loader](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.subnet_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.vpce-s3-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_ec2_managed_prefix_list.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_managed_prefix_list) | data source |
| [aws_iam_policy_document.es-loader-assume-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.es-loader-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.opensearch_access_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.opensearch_policy_allow_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_subnet.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | Allowed cidrs in security group | `list(string)` | `null` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | The number of availability zones for the cluster | `number` | `1` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_cold_storage_enabled"></a> [cold\_storage\_enabled](#input\_cold\_storage\_enabled) | Whether to enable the cold storage or not | `bool` | `null` | no |
| <a name="input_dedicated_master_config"></a> [dedicated\_master\_config](#input\_dedicated\_master\_config) | n/a | <pre>object({<br>    enabled               = optional(bool, false)<br>    master_instance_count = optional(number, 3)<br>    master_instance_type  = optional(string, "m6g.large.search")<br>  })</pre> | `{}` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The name of the cluster | `string` | n/a | yes |
| <a name="input_ebs_volume_size"></a> [ebs\_volume\_size](#input\_ebs\_volume\_size) | The volume size of the ebs volume | `number` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version of OpenSearch cluster | `string` | n/a | yes |
| <a name="input_hot_instance_count"></a> [hot\_instance\_count](#input\_hot\_instance\_count) | The amount of data nodes | `number` | n/a | yes |
| <a name="input_hot_instance_type"></a> [hot\_instance\_type](#input\_hot\_instance\_type) | The instance\_type used for the cluster | `string` | n/a | yes |
| <a name="input_log-buckets"></a> [log-buckets](#input\_log-buckets) | List with bucket names of buckets containing logs to be ingested by es-loader lambdas | `list(string)` | n/a | yes |
| <a name="input_managed-policies-es-loader"></a> [managed-policies-es-loader](#input\_managed-policies-es-loader) | List with the arns of aws managed policies needed for es-loader role | `list(string)` | n/a | yes |
| <a name="input_master_role_arn"></a> [master\_role\_arn](#input\_master\_role\_arn) | The arn of the Cloudops tooling SSO role | `string` | n/a | yes |
| <a name="input_saml_backend_role"></a> [saml\_backend\_role](#input\_saml\_backend\_role) | This backend role from the SAML IdP receives full permissions to the cluster | `string` | `""` | no |
| <a name="input_saml_enabled"></a> [saml\_enabled](#input\_saml\_enabled) | Whether to enable SAML or not | `bool` | `false` | no |
| <a name="input_saml_entity_id"></a> [saml\_entity\_id](#input\_saml\_entity\_id) | The unique Entity ID of the application in SAML Identity Provider | `string` | `null` | no |
| <a name="input_saml_metadata_content"></a> [saml\_metadata\_content](#input\_saml\_metadata\_content) | The metadata of the SAML application in xml format | `string` | `""` | no |
| <a name="input_saml_roles_key"></a> [saml\_roles\_key](#input\_saml\_roles\_key) | Element of the SAML assertion to use for backend roles | `string` | `""` | no |
| <a name="input_sqs-log-queues"></a> [sqs-log-queues](#input\_sqs-log-queues) | list with sqs queues for triggering corresponding es-loader lambda | `list(string)` | n/a | yes |
| <a name="input_standby_enabled"></a> [standby\_enabled](#input\_standby\_enabled) | Whether to enable multi AZ standby or not | `bool` | `false` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet ids | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tags | `map(string)` | n/a | yes |
| <a name="input_vpc_enabled"></a> [vpc\_enabled](#input\_vpc\_enabled) | Whether to launch opensearch within a VPC or not | `bool` | `false` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The Vpc ID | `string` | `""` | no |
| <a name="input_warm_storage_config"></a> [warm\_storage\_config](#input\_warm\_storage\_config) | n/a | <pre>object({<br>    enabled       = optional(bool, false)<br>    storage_type  = optional(string, "ultrawarm1.medium.search")<br>    storage_count = optional(number, 2)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | n/a |
| <a name="output_dashboard_endpoint"></a> [dashboard\_endpoint](#output\_dashboard\_endpoint) | n/a |
| <a name="output_es-loader-sg"></a> [es-loader-sg](#output\_es-loader-sg) | n/a |
| <a name="output_es_loader_role_arn"></a> [es\_loader\_role\_arn](#output\_es\_loader\_role\_arn) | n/a |
| <a name="output_oss_domain_endpoint"></a> [oss\_domain\_endpoint](#output\_oss\_domain\_endpoint) | n/a |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_TF_DOCS -->
