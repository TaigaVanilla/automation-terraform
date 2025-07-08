terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate01708543RG"
    storage_account_name = "tfstate01708543sa"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
  }
}