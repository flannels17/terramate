output "oss_domain_endpoint" {
  value = aws_opensearch_domain.cf_opensearch_cluster.endpoint
}

output "dashboard_endpoint" {
  value = "https://${aws_opensearch_domain.cf_opensearch_cluster.dashboard_endpoint}"
}

output "cluster_version" {
  value = aws_opensearch_domain.cf_opensearch_cluster.engine_version
}

output "security_group_id" {
  value = aws_security_group.vpc_enabled[*].id
}

output "vpc_id" {
  value = aws_security_group.vpc_enabled[*].vpc_id
}

output "subnet_ids" {
  value = var.subnet_ids
}

output "es_loader_role_arn" {
  value = aws_iam_role.es-loader-role.arn

}

output "es-loader-sg" {
  value = aws_security_group.es-loader-sg.id
}
