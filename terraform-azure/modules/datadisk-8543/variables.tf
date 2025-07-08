variable "disk_count" {}
variable "disk_names" {}
variable "vm_ids" {
  type = list(string)
}
variable "disk_storage_account_type" {
  default = "Standard_LRS"
}
variable "disk_size_gb" {
  default = 10
}
variable "resource_group_name" {}
variable "location" {}
variable "tags" {
  type = map(string)
}
