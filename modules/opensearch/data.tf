data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "opensearch_policy_allow_logging" {
  statement {
    effect = "Allow"

    principals {
      identifiers = ["es.amazonaws.com"]
      type        = "Service"
    }

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
    ]

    resources = ["arn:aws:logs:*"]

  }
}

# https://docs.aws.amazon.com/opensearch-service/latest/developerguide/saml.html#saml-domain-access
# https://docs.aws.amazon.com/opensearch-service/latest/developerguide/fgac.html#fgac-recommendations
data "aws_iam_policy_document" "opensearch_access_policies" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "es:ESHttp*"
    ]

    resources = [
      "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain}/*"
    ]
  }
  #checkov:skip=CKV_AWS_283: We are following AWS recommended policies
}

data "aws_subnet" "selected" {
  for_each = toset(var.subnet_ids)
  id       = each.key
}

data "aws_ec2_managed_prefix_list" "s3" {
  name = "com.amazonaws.${data.aws_region.current.name}.s3"
}

# data resources for es-loader role
data "aws_iam_policy_document" "es-loader-assume-role" {

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# TODO - we should refactor the security hub kmsDecrypt one to use the general statement with var.kms_arns
data "aws_iam_policy_document" "es-loader-policy" {
  # checkov:skip=CKV_AWS_108: "Ensure IAM policies does not allow data exfiltration: low priority, we can look into it if time permits it"
  statement {
    sid    = "allowEsReceiveMessage"
    effect = "Allow"
    actions = [
      "SQS:GetQueueAttributes",
      "SQS:ChangeMessageVisibility",
      "SQS:DeleteMessage",
      "SQS:ReceiveMessage"
    ]
    resources = var.sqs-log-queues
  }

  statement {
    sid       = "allowGetS3Object"
    effect    = "Allow"
    actions   = ["S3:GetObject"]
    resources = [for arn in var.log-buckets : "${arn}/*"]
  }

  statement {
    sid       = "AllowKMSDecrypt"
    effect    = "Allow"
    actions   = ["kms:Decrypt"]
    resources = [for arn in var.kms_arns : "${arn}"]
  }

  statement {
    sid       = "kmsDecrypt"
    effect    = "Allow"
    actions   = ["kms:Decrypt", ]
    resources = ["arn:aws:kms:eu-central-1:232852408236:key/efeb9dbb-165e-43d1-8804-5708bf5bf861"]
  }

}
