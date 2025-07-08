output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.log.name
}

output "recovery_services_vault_name" {
  value = azurerm_recovery_services_vault.vault.name
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "storage_account_uri" {
  value = azurerm_storage_account.storage.primary_blob_endpoint
}