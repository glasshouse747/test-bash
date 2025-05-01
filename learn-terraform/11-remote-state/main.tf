resource "null_resource" "test" {}

terraform {
  backend "azurerm" {
    use_cli              = true
    subscription_id      = "eb986b09-9743-4aa1-b10f-53da04d8708c"
    resource_group_name  = "my-first-rg"
    storage_account_name = "mydevops"
    container_name       = "roboshop-state-files"
    key                  = "test.terraform.tfstate"
  }
}