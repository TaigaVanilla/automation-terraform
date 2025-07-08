resource "azurerm_postgresql_flexible_server" "db" {
  name                   = var.db_name
  location               = var.location
  resource_group_name    = var.resource_group_name
  administrator_login    = var.db_admin_username
  administrator_password = var.db_admin_password
  sku_name               = var.db_sku
  version                = var.db_version
  storage_mb             = var.db_storage_mb

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = false
  zone                         = "1"
  delegated_subnet_id          = null
  private_dns_zone_id          = null

  authentication {
    active_directory_auth_enabled = false
    password_auth_enabled         = true
  }

  tags = var.tags
}
