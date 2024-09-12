variable "roles_config" {
  type = list(object({
    role_name           = optional(string)
    description         = optional(string)
    cluster_permissions = optional(list(string))
    backend_roles       = optional(list(string))
    index_permissions = optional(list(object({
      index_patterns  = optional(list(string))
      allowed_actions = optional(list(string))
    })))
    tenant_permissions = optional(list(object({
      tenant_patterns = optional(list(string))
      allowed_actions = optional(list(string))
    })))
  }))
}