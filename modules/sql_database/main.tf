resource "azurerm_mssql_database" "db" {
  name      = var.db_name
  server_id = var.server_id
  sku_name  = "Basic"
}

