# ---------------------------------------
# Resource Group
# ---------------------------------------
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# ---------------------------------------
# App Service Plan (Windows F1)
# ---------------------------------------
resource "azurerm_service_plan" "plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Windows"
  sku_name            = "F1"
}

# ---------------------------------------
# Windows App Service (.NET 6)
# ---------------------------------------
resource "azurerm_windows_web_app" "app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      dotnet_version = "v6.0"
    }
    # Add this line to explicitly disable always_on
    always_on = false
  }
}

# ---------------------------------------
# Storage Account
# ---------------------------------------
resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

# ---------------------------------------
# Storage Containers
# ---------------------------------------
resource "azurerm_storage_container" "containers" {
  for_each = toset([
    "buildartifactzip",
    "memorydumps",
    "stage-buildartifactzip",
    "testapi"
  ])

  name                  = each.value
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

# ---------------------------------------
# Key Vault
# ---------------------------------------
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                       = var.key_vault_name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"

  purge_protection_enabled   = false
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = ["Get", "Set", "List"]
  }
}

