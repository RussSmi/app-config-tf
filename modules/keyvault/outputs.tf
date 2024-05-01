output "kv_id" {
  description = "Value of the key vault id"
  value       = azurerm_key_vault.kv.id
}

output "kv_secret_id" {
  description = "Value of the key vault secret id"
  value       = azurerm_key_vault_secret.kvs.versionless_id
}

output "kv_msi_id" {
  description = "Value of the key vault MSI id"
  value       = azurerm_user_assigned_identity.kvmsi.id
}

output "kv_msi_client_id" {
  description = "Value of the key vault MSI client id"
  value       = azurerm_user_assigned_identity.kvmsi.client_id
}

output "kv_key_id" {
  description = "Value of the key vault key id"
  value       = azurerm_key_vault_key.key.versionless_id
}