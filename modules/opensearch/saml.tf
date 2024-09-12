resource "aws_opensearch_domain_saml_options" "opensearch_saml" {
  count       = var.saml_enabled ? 1 : 0
  domain_name = var.domain

  saml_options {
    enabled                 = true
    session_timeout_minutes = 60

    # The Saml assertion that contains the backend role
    roles_key = var.saml_roles_key

    # The group ID of the master backend role
    master_backend_role = var.saml_backend_role

    idp {

      # Example: https://portal.sso.eu-central-1.amazonaws.com/saml/assertion/**********
      entity_id = var.saml_entity_id

      # Metadata file <name>.xml
      metadata_content = sensitive(var.saml_metadata_content)
    }
  }

  depends_on = [aws_opensearch_domain.cf_opensearch_cluster]
}

# TODO: Automate the deployment of backend role using the opensearch provider
