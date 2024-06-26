locals {
  resource_location = lower(replace(var.location, " ", ""))
  ac_name           = "ac-${var.ident}-${var.loc}-${var.instance}"
}

data "azurerm_client_config" "current" {}

resource "azurerm_app_configuration" "appconf" {
  name                = local.ac_name
  resource_group_name = var.resource_group_name
  location            = local.resource_location

  sku                        = "standard"
  local_auth_enabled         = true
  public_network_access      = "Enabled"
  purge_protection_enabled   = false
  soft_delete_retention_days = 1

  identity {
    type = "UserAssigned"
    identity_ids = [
      var.kv_msi_id,
    ]
  }

  encryption {
    key_vault_key_identifier = var.kv_key_id
    identity_client_id       = var.kv_msi_client_id
  }

  replica {
    name     = "replica1"
    location = "West US"
  }

  tags = {
    environment = "development"
  }

  /* depends_on = [
    azurerm_key_vault_access_policy.client,
    azurerm_key_vault_access_policy.server,
  ] */
}

resource "azurerm_role_assignment" "appconf_dataowner" {
  scope                = azurerm_app_configuration.appconf.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = var.additoinalSpId
}

resource "azurerm_role_assignment" "appconf_dataowner_ghasp" {
  scope                = azurerm_app_configuration.appconf.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = var.ghspid
}

resource "azurerm_app_configuration_key" "appconf_key1" {
  configuration_store_id = azurerm_app_configuration.appconf.id
  key                    = "Demo-key1"
  type                   = "vault"
  label                  = "label1"
  vault_key_reference    = var.kv_secret_ref

  depends_on = [
    azurerm_role_assignment.appconf_dataowner,
    azurerm_role_assignment.appconf_dataowner_ghasp,
  ]
}


resource "azurerm_app_configuration_key" "appconf_key2" {
  configuration_store_id = azurerm_app_configuration.appconf.id
  key                    = "Demo-key2"
  type                   = "kv"
  label                  = "label1"
  value                  = "Demo-value2"

  depends_on = [
    azurerm_role_assignment.appconf_dataowner,
    azurerm_role_assignment.appconf_dataowner_ghasp,
  ]
}

resource "azurerm_app_configuration_key" "appconf_key3" {
  configuration_store_id = azurerm_app_configuration.appconf.id
  key                    = "Demo-key3"
  type                   = "kv"
  label                  = "label2"
  value                  = "Demo-value3"

  depends_on = [
    azurerm_role_assignment.appconf_dataowner,
    azurerm_role_assignment.appconf_dataowner_ghasp,
  ]
}

resource "azurerm_app_configuration_feature" "feature1" {
  configuration_store_id = azurerm_app_configuration.appconf.id
  description            = "Feature 1 description"
  name                   = "Feature 1"
  label                  = "Test label"
  enabled                = true
}

