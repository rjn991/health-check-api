terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstaterjn9912026"
    container_name       = "tfstate"
    key                  = "health-check-api.tfstate"

    use_azuread_auth = true
  }
}
