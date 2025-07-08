resource "azurerm_availability_set" "win_avset" {
  name                = var.win_avset_name
  location            = var.location
  resource_group_name = var.resource_group_name
  managed             = true
  tags                = var.tags
}

resource "azurerm_public_ip" "pip" {
  count               = var.vm_count
  name                = var.resource_names[count.index].pip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = var.vm_names[count.index]
  tags                = var.tags
}

resource "azurerm_network_interface" "nic" {
  count               = var.vm_count
  name                = var.resource_names[count.index].nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_allocation
    public_ip_address_id          = azurerm_public_ip.pip[count.index].id
  }

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "vm" {
  count                 = var.vm_count
  name                  = var.vm_names[count.index]
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  availability_set_id   = azurerm_availability_set.win_avset.id
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]

  source_image_reference {
    publisher = var.os_image_reference.publisher
    offer     = var.os_image_reference.offer
    sku       = var.os_image_reference.sku
    version   = var.os_image_reference.version
  }

  os_disk {
    name                 = var.resource_names[count.index].os_disk_name
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_storage_account_type
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  count                      = var.vm_count
  name                       = var.resource_names[count.index].ext_ama_name
  virtual_machine_id         = azurerm_windows_virtual_machine.vm[count.index].id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = var.extension_versions.antimalware
  auto_upgrade_minor_version = true
}
