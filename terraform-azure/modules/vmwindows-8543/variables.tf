variable "vm_count" {}
variable "resource_group_name" {}
variable "location" {}
variable "win_avset_name" {}
variable "vm_names" {
  type = map(string)
}
variable "resource_names" {
  type = map(object({
    pip_name     = string
    nic_name     = string
    os_disk_name = string
    ext_ama_name = string
  }))
}
variable "private_ip_allocation" {
  default = "Dynamic"
}
variable "vm_size" {}
variable "admin_username" {
  default = "azureuser"
}
variable "admin_password" {
  default = "Password123"
}
variable "subnet_id" {}
variable "os_disk_storage_account_type" {
  default = "Standard_LRS"
}
variable "storage_account_uri" {}
variable "os_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}
variable "extension_versions" {
  type = map(string)
}
variable "tags" {
  type = map(string)
}
