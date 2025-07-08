resource "azurerm_availability_set" "linux_avset" {
  name                         = var.linux_avset_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
  tags                         = var.tags
}

resource "azurerm_public_ip" "public_ips" {
  for_each            = var.vm_names
  name                = var.resource_names[each.key].pip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = each.value
  tags                = var.tags
}

resource "azurerm_network_interface" "nics" {
  for_each            = var.vm_names
  name                = var.resource_names[each.key].nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_allocation
    public_ip_address_id          = azurerm_public_ip.public_ips[each.key].id
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "linux_vms" {
  for_each                        = var.vm_names
  name                            = each.value
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  availability_set_id             = azurerm_availability_set.linux_avset.id
  network_interface_ids           = [azurerm_network_interface.nics[each.key].id]
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)
  }

  source_image_reference {
    publisher = var.os_image_reference.publisher
    offer     = var.os_image_reference.offer
    sku       = var.os_image_reference.sku
    version   = var.os_image_reference.version
  }

  os_disk {
    name                 = var.resource_names[each.key].os_disk_name
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_storage_account_type
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "nw_agent" {
  for_each                   = var.vm_names
  name                       = var.resource_names[each.key].ext_nw_name
  virtual_machine_id         = azurerm_linux_virtual_machine.linux_vms[each.key].id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = var.extension_versions.nw_agent
  auto_upgrade_minor_version = true
  depends_on                 = [azurerm_linux_virtual_machine.linux_vms]
}

resource "azurerm_virtual_machine_extension" "monitor_agent" {
  for_each                   = var.vm_names
  name                       = var.resource_names[each.key].ext_mon_name
  virtual_machine_id         = azurerm_linux_virtual_machine.linux_vms[each.key].id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = var.extension_versions.monitor_agent
  auto_upgrade_minor_version = true
  depends_on                 = [azurerm_linux_virtual_machine.linux_vms]
}

resource "null_resource" "show_hostname" {
  for_each = var.vm_names

  connection {
    type        = "ssh"
    user        = var.admin_username
    host        = azurerm_public_ip.public_ips[each.key].ip_address
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = ["hostname"]
  }
}
