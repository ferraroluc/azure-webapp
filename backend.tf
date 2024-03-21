terraform {
  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "example"
    container_name       = "tfstate"
    key                  = "example.tfstate"
  }
}
