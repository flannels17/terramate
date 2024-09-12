
resource "opensearch_role" "opensearch_role" {
  for_each = {
    for index, role in var.roles_config :
    role.role_name => role
  }
  role_name           = each.key
  description         = each.value.description
  cluster_permissions = each.value.cluster_permissions
  dynamic "index_permissions" {
    for_each = each.value.index_permissions
    content {
      index_patterns  = index_permissions.value.index_patterns
      allowed_actions = index_permissions.value.allowed_actions
    }
  }
  dynamic "tenant_permissions" {
    for_each = each.value.tenant_permissions
    content {
      tenant_patterns = tenant_permissions.value.tenant_patterns
      allowed_actions = tenant_permissions.value.allowed_actions
    }
  }
}



resource "opensearch_roles_mapping" "mapper" {
  for_each = {
    for index, role in var.roles_config :
    role.role_name => role
  }
  role_name     = each.key
  description   = each.value.description
  backend_roles = each.value.backend_roles

}
