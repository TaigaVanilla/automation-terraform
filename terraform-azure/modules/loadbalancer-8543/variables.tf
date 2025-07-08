variable "resource_group_name" {}
variable "location" {}
variable "lb_name" {}
variable "lb_pip_name" {}
variable "lb_sku" {}
variable "lb_frontend_ip_config_name" {}
variable "lb_backend_pool_name" {}
variable "linux_vm_nic_ids" {
  type = list(string)
}
variable "tags" {
  type = map(string)
}
