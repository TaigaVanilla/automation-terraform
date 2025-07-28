output "resource_group_name" {
  value = module.resource_group.name
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "log_analytics_workspace" {
  value = module.common.log_analytics_workspace_name
}

output "recovery_services_vault" {
  value = module.common.recovery_services_vault_name
}

output "storage_account_name" {
  value = module.common.storage_account_name
}

output "linux_vm_hostnames" {
  value = module.linux_vms.linux_vm_hostnames
}

output "linux_vm_domain_names" {
  value = module.linux_vms.linux_vm_domain_names
}

output "linux_vm_private_ips" {
  value = module.linux_vms.linux_vm_private_ips
}

output "linux_vm_public_ips" {
  value = module.linux_vms.linux_vm_public_ips
}

output "windows_vm_hostname" {
  value = module.windows_vm.windows_vm_hostname
}

output "windows_vm_domain_name" {
  value = module.windows_vm.windows_vm_domain_name
}

output "windows_vm_private_ip" {
  value = module.windows_vm.windows_vm_private_ip
}

output "windows_vm_public_ip" {
  value = module.windows_vm.windows_vm_public_ip
}

output "load_balancer_name" {
  value = module.loadbalancer.load_balancer_name
}

output "postgres_server_name" {
  value = module.postgres.postgres_server_name
}

