locals {
  resource_location   = lower(replace(var.location, " ", ""))
  resource_group_name = "rg-${var.ident}-${var.loc}-${var.instance}"
}
#-------------------------------
# Create main resource group
#-------------------------------
resource "azurerm_resource_group" "appconfig" {
  name     = local.resource_group_name
  location = local.resource_location
}

#-------------------------------
# calling the Key Vault module
#-------------------------------
module "key_vault" {
  source                     = "./modules/keyvault"
  location                   = local.resource_location
  ident                      = var.ident
  resource_group_name        = azurerm_resource_group.appconfig.name
  secret_value               = var.secret_value
  soft_delete_retention_days = var.soft_delete_retention_days
  instance                   = var.instance
}

module "app_config" {
  source              = "./modules/appconfig"
  resource_group_name = azurerm_resource_group.appconfig.name
  location            = local.resource_location
  ident               = var.ident
  kv_secret_ref       = module.key_vault.kv_secret_id
  kv_id               = module.key_vault.kv_id
  kv_msi_id           = module.key_vault.kv_msi_id
  kv_msi_client_id    = module.key_vault.kv_msi_client_id
  kv_key_id           = module.key_vault.kv_key_id
  instance            = var.instance
}