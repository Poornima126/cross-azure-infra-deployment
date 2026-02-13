terraform {
  backend "azurerm" {
    resource_group_name  = "rg-dev-poc-crossaccount"
    storage_account_name = "tfstatecross12345"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

