locals {
  location = "canadacentral"

  common_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "taiga.kobayashi"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }

  vm_names = {
    "vm0" = "vm0-8543"
    "vm1" = "vm1-8543"
    "vm2" = "vm2-8543"
  }

  resource_names = {
    for key, name in local.vm_names : key => {
      pip_name     = "${name}-pip"
      nic_name     = "${name}-nic"
      os_disk_name = "${name}-osdisk"
      ext_nw_name  = "${name}-nw"
      ext_mon_name = "${name}-mon"
    }
  }

  windows_vm_count = 1

  windows_vm_names = {
    for i in range(local.windows_vm_count) :
    i => "winvm-${i}-8543"
  }

  windows_resource_names = {
    for i, name in local.windows_vm_names :
    i => {
      pip_name     = "${name}-pip"
      nic_name     = "${name}-nic"
      os_disk_name = "${name}-osdisk"
      ext_ama_name = "${name}-antimalware"
    }
  }

  disk_count = 4

  disk_names = [
    for i in range(local.disk_count) :
    "8543-datadisk-${i + 1}"
  ]
}

module "resource_group" {
  source              = "./modules/rgroup-8543"
  resource_group_name = "8543-RG"
  location            = local.location
  tags                = local.common_tags
}

module "network" {
  source                = "./modules/network-8543"
  resource_group_name   = module.resource_group.name
  location              = local.location
  vnet_name             = "8543-VNET"
  vnet_address_space    = ["10.0.0.0/16"]
  subnet_name           = "8543-SUBNET"
  subnet_address_prefix = ["10.0.1.0/24"]
  nsg_name              = "8543-NSG"
  nsg_rule_name         = "8543-NSG-rule"
  nsg_rule_priority     = 100
  allowed_ports         = [22, 3389, 5985, 80]
  tags                  = local.common_tags
}

module "common" {
  source                           = "./modules/common-8543"
  resource_group_name              = module.resource_group.name
  location                         = local.location
  log_analytics_workspace_name     = "8543-loganalytics"
  log_analytics_sku                = "PerGB2018"
  log_analytics_retention_days     = 30
  recovery_services_vault_name     = "vault-8543"
  recovery_services_vault_sku      = "Standard"
  storage_account_name             = "st8543"
  storage_account_tier             = "Standard"
  storage_account_replication_type = "LRS"
  tags                             = local.common_tags
}

module "linux_vms" {
  source              = "./modules/vmlinux-8543"
  location            = local.location
  resource_group_name = module.resource_group.name

  subnet_id           = module.network.subnet_id
  storage_account_uri = module.common.storage_account_uri

  vm_names         = local.vm_names
  resource_names   = local.resource_names
  linux_avset_name = "8543-linux-avset"
  vm_size          = "Standard_B1ms"

  os_image_reference = {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  extension_versions = {
    nw_agent      = "1.0"
    monitor_agent = "1.0"
  }
  tags = local.common_tags
}

module "windows_vm" {
  source              = "./modules/vmwindows-8543"
  vm_count            = local.windows_vm_count
  location            = local.location
  resource_group_name = module.resource_group.name

  subnet_id           = module.network.subnet_id
  storage_account_uri = module.common.storage_account_uri

  vm_names       = local.windows_vm_names
  resource_names = local.windows_resource_names
  win_avset_name = "8543-win-avset"
  vm_size        = "Standard_B1ms"

  os_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  extension_versions = {
    antimalware = "1.5"
  }

  tags = local.common_tags
}

module "datadisks" {
  source              = "./modules/datadisk-8543"
  disk_count          = local.disk_count
  resource_group_name = module.resource_group.name
  location            = local.location
  disk_names          = local.disk_names
  vm_ids = concat(
    module.linux_vms.linux_vm_ids,
    module.windows_vm.windows_vm_id
  )
  tags = local.common_tags
}

module "loadbalancer" {
  source                     = "./modules/loadbalancer-8543"
  resource_group_name        = module.resource_group.name
  location                   = local.location
  lb_name                    = "8543-loadbalancer"
  lb_pip_name                = "8543-lb-pip"
  lb_sku                     = "Standard"
  lb_frontend_ip_config_name = "PublicFrontend"
  lb_backend_pool_name       = "8543-backend-pool"
  linux_vm_nic_ids           = module.linux_vms.linux_vm_nic_ids
  tags                       = local.common_tags
}

module "postgres" {
  source                = "./modules/database-8543"
  location              = local.location
  resource_group_name   = module.resource_group.name
  db_name               = "pg8543server"
  db_sku                = "B_Standard_B1ms"
  db_version            = "13"
  db_storage_mb         = 32768
  backup_retention_days = 7
  tags                  = local.common_tags
}
