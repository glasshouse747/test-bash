provider "azurerm" {
  subscription_id      = "eb986b09-9743-4aa1-b10f-53da04d8708c"
  features {}
}

resource "azurerm_storage_account" "tfstorage" {
  name                     = "mydevopshop"
  resource_group_name      = "my-first-rg"
  location                 = "UK West"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "tfscontainer" {
  depends_on = [azurerm_storage_account.tfstorage]
  name                  = "roboshop-state-files"
  storage_account_id    = azurerm_storage_account.tfstorage.id
  container_access_type = "private"
}