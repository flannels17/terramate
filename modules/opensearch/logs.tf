# https://opensearch.org/docs/latest/install-and-configure/configuring-opensearch/logs/

#trivy:ignore:AVD-AWS-0017
resource "aws_cloudwatch_log_group" "opensearch_log_group_index_slow" {
  name              = "/aws/opensearch/${var.domain}/index-slow"
  retention_in_days = 30
  tags              = var.tags

  #checkov:skip=CKV_AWS_158:we don't need encryption for our logs
  #checkov:skip=CKV_AWS_338:We keep our logs for 30 days
}

#trivy:ignore:AVD-AWS-0017
resource "aws_cloudwatch_log_group" "opensearch_log_group_search_slow" {
  name              = "/aws/opensearch/${var.domain}/search-slow"
  retention_in_days = 30
  tags              = var.tags

  #checkov:skip=CKV_AWS_158:we don't need encryption for our logs
  #checkov:skip=CKV_AWS_338:We keep our logs for 30 days
}

#trivy:ignore:AVD-AWS-0017
resource "aws_cloudwatch_log_group" "opensearch_log_group_es_application" {
  name              = "/aws/opensearch/${var.domain}/es_application"
  retention_in_days = 30
  tags              = var.tags

  #checkov:skip=CKV_AWS_158:we don't need encryption for our logs
  #checkov:skip=CKV_AWS_338:We keep our logs for 30 days
}

#trivy:ignore:AVD-AWS-0017
resource "aws_cloudwatch_log_group" "opensearch_log_group_audit_logs" {
  name              = "/aws/opensearch/${var.domain}/audit_logs"
  retention_in_days = 30
  tags              = var.tags

  #checkov:skip=CKV_AWS_158:we don't need encryption for our logs
  #checkov:skip=CKV_AWS_338:We keep our logs for 30 days
}

resource "aws_cloudwatch_log_resource_policy" "opensearch" {
  policy_name     = "opensearch-policy"
  policy_document = data.aws_iam_policy_document.opensearch_policy_allow_logging.json
}
