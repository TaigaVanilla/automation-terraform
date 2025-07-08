variable "resource_group_name" {}
variable "location" {}
variable "db_name" {}
variable "db_sku" {}
variable "db_version" {}
variable "db_storage_mb" {}
variable "backup_retention_days" {}
variable "db_admin_username" {
  default = "admin8543"
}
variable "db_admin_password" {
  default = "Password123"
}
variable "tags" {
  type = map(string)
}
