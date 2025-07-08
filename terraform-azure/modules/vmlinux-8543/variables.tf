variable "resource_group_name" {}
variable "location" {}
variable "linux_avset_name" {}
variable "subnet_id" {}
variable "vm_names" {
  type = map(string)
}
variable "resource_names" {
  type = map(object({
    pip_name     = string
    nic_name     = string
    os_disk_name = string
    ext_nw_name  = string
    ext_mon_name = string
  }))
}
variable "private_ip_allocation" {
  default = "Dynamic"
}
variable "vm_size" {}
variable "admin_username" {
  default = "azureuser"
}
variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}
variable "private_key_path" {
  default = "~/.ssh/id_rsa"
}
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
