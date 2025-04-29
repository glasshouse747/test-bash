# resource "null_resource" "test" {}

# output "test" {
#   value = length(null_resource.test)
# }
#

provider "azurerm" {
  features {}
  subscription_id = "eb986b09-9743-4aa1-b10f-53da04d8708c"
}

variable "nodes" {
  default = {
    test2 = {
      private_ip_address_allocation = "Static"
    }
    test1 = {
    }
  }
}

resource "azurerm_network_interface" "privateip" {
  for_each            = var.nodes
  name                = "test-ip"
  location            = "UK West"
  resource_group_name = "my-first-rg"

  ip_configuration {
    name                          = "test-ip"
    subnet_id                     = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Network/virtualNetworks/test-network/subnets/default"
    private_ip_address_allocation = length(each.value["private_ip_address_allocation"]) > 0 ? each.value["private_ip_address_allocation"] : "private_ip_address_allocation"
  }
}

# condition ? true_val : false_val
# Conditions in terraform are meant to pick a value, Not meant to run a resource or not