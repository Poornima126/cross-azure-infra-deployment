resource "random_password" "sql_password" {
  length  = 16
  special = true
}

resource "azurerm_mssql_server" "sql" {
  name                         = var.sql_server_name
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_login
  administrator_login_password = random_password.sql_password.result
}

resource "azurerm_key_vault_secret" "sql_password_secret" {
  name         = "SqlAdminPassword"
  value        = random_password.sql_password.result
  key_vault_id = var.keyvault_id
}

output "server_id" {
  value = azurerm_mssql_server.sql.id
}

