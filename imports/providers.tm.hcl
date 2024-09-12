generate_hcl "_providers.tf" {
  lets {
    required_providers = { for provider, content in tm_try(global.terraform.providers, {}) :
      provider => {
        source  = content.source
        version = content.version
        } if tm_alltrue([
          tm_try(v.enabled, true),
          tm_length(tm_split(".", provider)) == 1,
      ])
    }

    providers = { for provider, content in tm_try(global.terraform.providers, {}) :
      provider => content.config if tm_alltrue([
        tm_length(tm_split(".", provider)) == 1,
        tm_try(content.enabled, true),
        tm_can(content.config)
      ])
    }

    providers_aliases = { for provider, content in tm_try(global.terraform.providers, {}) :
      provider => content.config if tm_alltrue([
        tm_length(tm_split(".", provider)) == 2,
        tm_try(content.enabled, true),
        tm_can(content.config)
      ])
    }
  }

  content {
    # terraform version constraints
    terraform {
      required_version = tm_try(global.terraform.version, "~> 1.7")
    }

    # Provider version constraints
    terraform {
      tm_dynamic "required_providers" {
        attributes = let.required_providers
      }
    }

    # Provider configs
    tm_dynamic "provider" {
      for_each   = let.providers
      labels     = [provider.key]
      attributes = provider.value
    }

    # Provider aliases
    tm_dynamic "provider" {
      for_each   = let.providers_aliases
      labels     = [tm_split(".", provider.key)[0]]
      attributes = provider.value

      content {
        alias = tm_split(".", provider.key)[1]
      }
    }
  }
}
