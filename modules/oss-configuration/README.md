# oss-configuration

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_opensearch"></a> [opensearch](#requirement\_opensearch) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_opensearch"></a> [opensearch](#provider\_opensearch) | 2.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [opensearch_component_template.each](https://registry.terraform.io/providers/opensearch-project/opensearch/latest/docs/resources/component_template) | resource |
| [opensearch_composable_index_template.each](https://registry.terraform.io/providers/opensearch-project/opensearch/latest/docs/resources/composable_index_template) | resource |
| [opensearch_ism_policy.each](https://registry.terraform.io/providers/opensearch-project/opensearch/latest/docs/resources/ism_policy) | resource |
| [opensearch_role.opensearch_role](https://registry.terraform.io/providers/opensearch-project/opensearch/latest/docs/resources/role) | resource |
| [opensearch_roles_mapping.mapper](https://registry.terraform.io/providers/opensearch-project/opensearch/latest/docs/resources/roles_mapping) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_roles_config"></a> [roles\_config](#input\_roles\_config) | n/a | <pre>list(object({<br>    role_name           = optional(string)<br>    description         = optional(string)<br>    cluster_permissions = optional(list(string))<br>    backend_roles       = optional(list(string))<br>    index_permissions = optional(list(object({<br>      index_patterns  = optional(list(string))<br>      allowed_actions = optional(list(string))<br>    })))<br>    tenant_permissions = optional(list(object({<br>      tenant_patterns = optional(list(string))<br>      allowed_actions = optional(list(string))<br>    })))<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
