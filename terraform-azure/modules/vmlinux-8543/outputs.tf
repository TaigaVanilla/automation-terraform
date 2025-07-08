output "linux_vm_hostnames" {
  value = values(azurerm_linux_virtual_machine.linux_vms)[*].name
}

output "linux_vm_domain_names" {
  value = values(azurerm_public_ip.public_ips)[*].fqdn
}

output "linux_vm_private_ips" {
  value = values(azurerm_network_interface.nics)[*].ip_configuration[0].private_ip_address
}

output "linux_vm_public_ips" {
  value = values(azurerm_public_ip.public_ips)[*].ip_address
}

output "linux_vm_ids" {
  value = values(azurerm_linux_virtual_machine.linux_vms)[*].id
}

output "linux_vm_nic_ids" {
  value = values(azurerm_network_interface.nics)[*].id
}