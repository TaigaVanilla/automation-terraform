variable "resource_group_name" {}
variable "location" {}
variable "vnet_name" {}
variable "vnet_address_space" {}
variable "subnet_name" {}
variable "subnet_address_prefix" {}
variable "nsg_name" {}
variable "nsg_rule_name" {}
variable "nsg_rule_priority" {}
variable "allowed_ports" {
  type = list(number)
}
variable "tags" {
  type = map(string)
}
