module "rg" {
  source   = "./modules/resource_group"
  name     = var.rg_name
  location = var.location
}

module "storage" {
  source               = "./modules/storage_account"
  rg_name              = module.rg.name
  location             = var.location
  storage_account_name = var.storage_account_name
  container_name       = var.container_name
}

module "keyvault" {
  source   = "./modules/key_vault"
  rg_name  = module.rg.name
  location = var.location
  kv_name  = var.kv_name
}

module "sql_server" {
  source          = "./modules/sql_server"
  rg_name         = module.rg.name
  location        = var.location
  sql_server_name = var.sql_server_name
  admin_login     = var.sql_admin
  keyvault_id     = module.keyvault.kv_id
}

module "sql_database" {
  source    = "./modules/sql_database"
  db_name   = var.db_name
  server_id = module.sql_server.server_id
}

module "app_service" {
  source              = "./modules/app_service"
  rg_name             = module.rg.name
  location            = var.location
  app_name            = var.app_name
  storage_account_id  = module.storage.storage_id
}

module "function_app" {
  source               = "./modules/function_app"
  rg_name              = module.rg.name
  location             = var.location
  function_name        = var.function_name
  storage_account_name = module.storage.storage_name
  storage_account_key  = module.storage.storage_key
  storage_account_id   = module.storage.storage_id
}

