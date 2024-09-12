locals {
  security                        = yamldecode(file("${path.module}/files/data.yaml")).security
  cluster-settings                = yamldecode(file("${path.module}/files/data.yaml")).cluster-settings
  index_state_management_policies = yamldecode(file("${path.module}/files/data.yaml")).index_state_management_policies
  component-templates             = yamldecode(file("${path.module}/files/data.yaml")).component-templates
  index-templates                 = yamldecode(file("${path.module}/files/data.yaml")).index-templates
  index-rollover                  = yamldecode(file("${path.module}/files/data.yaml")).index-rollover
  legacy-index-template           = yamldecode(file("${path.module}/files/data.yaml")).legacy-index-template
  deleted-old-index-template      = yamldecode(file("${path.module}/files/data.yaml")).deleted-old-index-template
  ocsf-schema-core                = yamldecode(file("${path.module}/files/data.yaml")).ocsf-schema-core
}

resource "opensearch_composable_index_template" "each" {
  for_each   = merge(local.index-templates, local.index-rollover)
  depends_on = [opensearch_component_template.each]
  name       = each.key
  body       = each.value
}

resource "opensearch_component_template" "each" {
  for_each = merge(local.component-templates)
  name     = each.key
  body     = each.value
}

resource "opensearch_ism_policy" "each" {
  for_each  = merge(local.index_state_management_policies)
  policy_id = each.key
  body      = each.value
}
