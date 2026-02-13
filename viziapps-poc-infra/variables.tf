variable "location" {
  description = "Azure Region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}

variable "app_service_plan_name" {
  description = "App Service Plan Name"
  type        = string
}

variable "app_service_name" {
  description = "App Service Name (globally unique)"
  type        = string
}

variable "storage_account_name" {
  description = "Storage Account Name (lowercase, globally unique)"
  type        = string
}

variable "key_vault_name" {
  description = "Key Vault Name (globally unique)"
  type        = string
}

