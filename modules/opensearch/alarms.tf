resource "aws_cloudwatch_metric_alarm" "oss_cpu_metric" {
  alarm_name                = "${local.alarm_prefix}cpu"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  threshold                 = 70
  alarm_description         = "This metric monitors cpu utilization on the OSS cluster"
  insufficient_data_actions = []
  treat_missing_data        = "breaching"
  tags                      = var.tags
  alarm_actions             = [local.alarm_topic]
  ok_actions                = [local.alarm_topic]

  metric_query {
    id = "m1"

    metric {
      metric_name = "CPUUtilization"
      namespace   = "AWS/ES"
      period      = 120
      stat        = "Average"
      dimensions = {
        ClientId   = var.aws_account_id
        DomainName = var.domain
      }
    }
    return_data = "true"
  }
}

resource "aws_cloudwatch_metric_alarm" "oss_jvmmem_metric" {
  alarm_name                = "${local.alarm_prefix}JVMMemoryPressure"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  threshold                 = 70
  alarm_description         = "This metric monitors JVM memory pressure on the OSS cluster"
  insufficient_data_actions = []
  treat_missing_data        = "breaching"
  tags                      = var.tags
  alarm_actions             = [local.alarm_topic]
  ok_actions                = [local.alarm_topic]

  metric_query {
    id = "m1"

    metric {
      metric_name = "JVMMemoryPressure"
      namespace   = "AWS/ES"
      period      = 120
      stat        = "Average"
      dimensions = {
        ClientId   = var.aws_account_id
        DomainName = var.domain
      }
    }
    return_data = "true"
  }
}

# resource "aws_cloudwatch_metric_alarm" "oss_sysmem_metric" {
#   alarm_name                = "${local.alarm_prefix}SysMemoryUtilization"
#   comparison_operator       = "GreaterThanOrEqualToThreshold"
#   evaluation_periods        = 2
#   threshold                 = 95
#   alarm_description         = "This metric monitors system memory percentage on the OSS cluster"
#   insufficient_data_actions = []
#   treat_missing_data        = "breaching"
#   tags                      = var.tags
#   alarm_actions             = [local.alarm_topic]
#   ok_actions                = [local.alarm_topic]

#   metric_query {
#     id = "m1"

#     metric {
#       metric_name = "SysMemoryUtilization"
#       namespace   = "AWS/ES"
#       period      = 120
#       stat        = "Average"
#       dimensions = {
#         ClientId   = var.aws_account_id
#         DomainName = var.domain
#       }
#     }
#     return_data = "true"
#   }
# }

resource "aws_cloudwatch_metric_alarm" "oss_freestorage_metric" {
  alarm_name                = "${local.alarm_prefix}FreeStorageSpace"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = 2
  threshold                 = 30
  alarm_description         = "This metric monitors free storage on the OSS cluster"
  insufficient_data_actions = []
  treat_missing_data        = "breaching"
  tags                      = var.tags
  alarm_actions             = [local.alarm_topic]
  ok_actions                = [local.alarm_topic]

  metric_query {
    id = "m1"

    metric {
      metric_name = "FreeStorageSpace"
      namespace   = "AWS/ES"
      period      = 120
      stat        = "Average"
      dimensions = {
        ClientId   = var.aws_account_id
        DomainName = var.domain
      }
    }
    return_data = "true"
  }
}

// The ClusterStatus has three metrics: ClusterStatus.green .yellow and .red which act as booleans.
resource "aws_cloudwatch_metric_alarm" "oss_clusterstatus_metric" {
  alarm_name                = "${local.alarm_prefix}ClusterStatus.green"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 2
  threshold                 = 1
  alarm_description         = "This metric monitors cluster status on the OSS cluster"
  insufficient_data_actions = []
  treat_missing_data        = "breaching"
  tags                      = var.tags
  alarm_actions             = [local.alarm_topic]
  ok_actions                = [local.alarm_topic]

  metric_query {
    id = "m1"

    metric {
      metric_name = "ClusterStatus.green"
      namespace   = "AWS/ES"
      period      = 120
      stat        = "Average"
      dimensions = {
        ClientId   = var.aws_account_id
        DomainName = var.domain
      }
    }
    return_data = "true"
  }
}

resource "aws_cloudwatch_metric_alarm" "oss_http_metric" {
  alarm_name                = "${local.alarm_prefix}http_avg_error_sum"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  threshold                 = 20
  alarm_description         = "This metric monitors http status codes on the OSS cluster"
  insufficient_data_actions = []
  treat_missing_data        = "breaching"
  tags                      = var.tags
  alarm_actions             = [local.alarm_topic]
  ok_actions                = [local.alarm_topic]

  metric_query {
    id          = "e1"
    expression  = "SUM([m3xx, m4xx, m5xx])"
    label       = "Sum bad http codes"
    return_data = "true"
  }

  metric_query {
    id = "m3xx"

    metric {
      metric_name = "3xx"
      namespace   = "AWS/ES"
      period      = 120
      stat        = "Average"
      dimensions = {
        ClientId   = var.aws_account_id
        DomainName = var.domain
      }
    }
  }

  metric_query {
    id = "m4xx"

    metric {
      metric_name = "4xx"
      namespace   = "AWS/ES"
      period      = 120
      stat        = "Average"
      dimensions = {
        ClientId   = var.aws_account_id
        DomainName = var.domain
      }
    }
  }

  metric_query {
    id = "m5xx"

    metric {
      metric_name = "5xx"
      namespace   = "AWS/ES"
      period      = 120
      stat        = "Average"
      dimensions = {
        ClientId   = var.aws_account_id
        DomainName = var.domain
      }
    }
  }
}
