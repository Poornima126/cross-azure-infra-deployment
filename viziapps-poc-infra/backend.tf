terraform {
  backend "azurerm" {
    resource_group_name  = "Dev"
    storage_account_name = "test1302"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}
