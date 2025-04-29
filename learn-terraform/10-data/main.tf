data "azurerm_resource_group" "example" {
  name = "my-first-rg"
}

output "id" {
  value = data.azurerm_resource_group.example
}

provider "azurerm" {
  features {}
  subscription_id = "eb986b09-9743-4aa1-b10f-53da04d8708c"
}