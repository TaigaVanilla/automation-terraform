resource "azurerm_managed_disk" "disks" {
  count                = var.disk_count
  name                 = var.disk_names[count.index]
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.disk_storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "attachments" {
  count              = var.disk_count
  managed_disk_id    = azurerm_managed_disk.disks[count.index].id
  virtual_machine_id = var.vm_ids[count.index]
  lun                = count.index
  caching            = "ReadWrite"
}
