resource "null_resource" "test" {
}

terraform {
  backend "azurerm" {
    use_cli              = true
    # tenant_id            = "00000000-0000-0000-0000-000000000000"
    subscription_id      = "eb986b09-9743-4aa1-b10f-53da04d8708c"
    resource_group_name  = "my-first-rg"
    storage_account_name = "roboshop-state-files"
    container_name       = "roboshop-state-files"
    key                  = "test.terraform.tfstate"
  }
}