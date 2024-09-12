locals {
  logs = {
    "AUDIT_LOGS"          = aws_cloudwatch_log_group.opensearch_log_group_audit_logs.arn
    "ES_APPLICATION_LOGS" = aws_cloudwatch_log_group.opensearch_log_group_es_application.arn
    "INDEX_SLOW_LOGS"     = aws_cloudwatch_log_group.opensearch_log_group_index_slow.arn
    "SEARCH_SLOW_LOGS"    = aws_cloudwatch_log_group.opensearch_log_group_search_slow.arn
  }

  alarm_prefix = "oss_alarm_"
  alarm_topic  = "arn:aws:sns:eu-central-1:${var.aws_account_id}:ebbr-cloudfoundation-alerts"
}
