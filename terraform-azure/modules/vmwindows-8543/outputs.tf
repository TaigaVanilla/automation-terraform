output "windows_vm_hostname" {
  value = azurerm_windows_virtual_machine.vm[*].name
}

output "windows_vm_domain_name" {
  value = azurerm_public_ip.pip[*].fqdn
}

output "windows_vm_private_ip" {
  value = azurerm_network_interface.nic[*].ip_configuration[0].private_ip_address
}

output "windows_vm_public_ip" {
  value = azurerm_public_ip.pip[*].ip_address
}

output "windows_vm_id" {
  value = azurerm_windows_virtual_machine.vm[*].id
}
