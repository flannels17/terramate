globals "terraform" "providers" "azurerm" {
  enabled = true

  source  = "hashicorp/azurerm"
  version = "~> 4.0"
  config = {
    features        = {}
    subscription_id = ""
  }
}
