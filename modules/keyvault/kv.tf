locals {
  resource_location = lower(replace(var.location, " ", ""))
  kv_name           = "kv-${var.ident}-${var.loc}-001"
  kv_secret_name    = "kvs-${var.ident}-${var.loc}"
  msi_name          = "msi-${var.ident}-${var.loc}"
  kv_key_name       = "kvkey-${var.ident}-${var.loc}"
}

data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "kvmsi" {
  name                = local.msi_name
  location            = local.resource_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_key_vault" "kv" {
  name                        = local.kv_name
  location                    = local.resource_location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = var.sku_name
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = true
  enabled_for_disk_encryption = true
}

resource "azurerm_key_vault_access_policy" "server" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.kvmsi.principal_id

  key_permissions    = ["Get", "UnwrapKey", "WrapKey"]
  secret_permissions = ["Get"]
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions    = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "GetRotationPolicy"]
  secret_permissions = ["Get", "Set", "List"]
}

resource "azurerm_key_vault_key" "key" {
  name         = local.kv_key_name
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey"
  ]

  depends_on = [
    azurerm_key_vault_access_policy.client,
    azurerm_key_vault_access_policy.server,
  ]
}

resource "azurerm_key_vault_secret" "kvs" {
  name         = local.kv_secret_name
  value        = var.secret_value
  key_vault_id = azurerm_key_vault.kv.id
}