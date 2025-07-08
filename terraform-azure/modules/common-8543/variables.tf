variable "resource_group_name" {}
variable "location" {}
variable "log_analytics_workspace_name" {}
variable "log_analytics_sku" {}
variable "log_analytics_retention_days" {}
variable "recovery_services_vault_name" {}
variable "recovery_services_vault_sku" {}
variable "storage_account_name" {}
variable "storage_account_tier" {}
variable "storage_account_replication_type" {}
variable "tags" {
  type = map(string)
}
