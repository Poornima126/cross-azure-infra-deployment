output "storage_name" {
  value = azurerm_storage_account.sa.name
}

output "storage_key" {
  value     = azurerm_storage_account.sa.primary_access_key
  sensitive = true
}

output "storage_id" {
  value = azurerm_storage_account.sa.id
}

