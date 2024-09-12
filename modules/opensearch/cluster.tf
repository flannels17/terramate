resource "aws_opensearch_domain" "cf_opensearch_cluster" {
  domain_name    = var.domain
  engine_version = try(var.engine_version, "OpenSearch_2.13")
  tags           = var.tags

  cluster_config {
    instance_type  = var.hot_instance_type
    instance_count = try(var.hot_instance_count, 1)

    #checkov:skip=CKV_AWS_318:At the current state we are not using dedicated masters
    #checkov:skip=CKV2_AWS_59:At the current state we are not using dedicated masters
    dedicated_master_enabled = var.dedicated_master_config.enabled
    dedicated_master_count   = var.dedicated_master_config.enabled ? var.dedicated_master_config.master_instance_count : 0
    dedicated_master_type    = var.dedicated_master_config.enabled ? var.dedicated_master_config.master_instance_type : null

    warm_enabled = var.warm_storage_config.enabled
    warm_type    = var.warm_storage_config.enabled ? var.warm_storage_config.storage_type : null
    warm_count   = var.warm_storage_config.enabled ? var.warm_storage_config.storage_count : null

    # Dedicated master & warm storage must be enabled
    cold_storage_options {
      enabled = var.dedicated_master_config.enabled && var.warm_storage_config.enabled == true ? var.cold_storage_enabled : null
    }

    # https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-multiaz.html#managedomains-za-summary
    multi_az_with_standby_enabled = var.standby_enabled
    zone_awareness_enabled        = var.availability_zones > 1 ? true : false

    dynamic "zone_awareness_config" {
      for_each = var.availability_zones > 1 ? [var.availability_zones] : []
      content {
        availability_zone_count = zone_awareness_config.value
      }
    }
    #checkov:skip=CKV_AWS_317: checkov bug ?

  }

  access_policies = data.aws_iam_policy_document.opensearch_access_policies.json

  advanced_security_options {
    enabled = true
    #checkov:skip=CKV2_AWS_52: Not required as we are using IAM and not an internal user

    master_user_options {
      master_user_arn = var.master_role_arn
    }
  }

  dynamic "vpc_options" {
    for_each = var.vpc_enabled ? [1] : []
    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = [aws_security_group.vpc_enabled[0].id]
    }
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  #checkov:skip=CKV_AWS_247: We don't require KMS encryption
  node_to_node_encryption {
    enabled = true
  }

  encrypt_at_rest {
    enabled = true
  }

  ebs_options {
    ebs_enabled = true
    volume_size = var.ebs_volume_size # From 10 GiB to 2048 GiB
    volume_type = "gp3"
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  #checkov:skip=CKV_AWS_317: checkov bug ?
  dynamic "log_publishing_options" {
    #checkov:skip=CKV_AWS_317: checkov bug ?
    for_each = local.logs
    content {
      enabled                  = true
      log_type                 = log_publishing_options.key
      cloudwatch_log_group_arn = log_publishing_options.value
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.opensearch_log_group_audit_logs,
    aws_cloudwatch_log_group.opensearch_log_group_es_application,
    aws_cloudwatch_log_group.opensearch_log_group_index_slow,
    aws_cloudwatch_log_group.opensearch_log_group_search_slow
  ]

  # https://docs.aws.amazon.com/opensearch-service/latest/developerguide/ac.html#ac-advanced
  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  software_update_options {
    auto_software_update_enabled = true
  }
}
