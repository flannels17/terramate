# https://docs.aws.amazon.com/opensearch-service/latest/developerguide/slr.html
resource "aws_iam_service_linked_role" "opensearch" {
  aws_service_name = "es.amazonaws.com"
  tags             = var.tags
}

resource "aws_iam_role" "es-loader-role" {
  name               = "es-loader"
  assume_role_policy = data.aws_iam_policy_document.es-loader-assume-role.json
  inline_policy {
    name   = "es-loader-policies"
    policy = data.aws_iam_policy_document.es-loader-policy.json
  }
  managed_policy_arns = var.managed-policies-es-loader
}