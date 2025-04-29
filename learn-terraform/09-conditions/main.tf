terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
  }
}
# resource "null_resource" "test" {}

# output "test" {
#   value = length(null_resource.test)
# }
#

provider "azurerm" {
  features {}
  subscription_id = "eb986b09-9743-4aa1-b10f-53da04d8708c"
}

# variable "nodes" {
#   default = {
#     test2 = {
#       private_ip_address_allocation = "Static"
#     }
#     test1 = {
#     }
#   }
# }
#
# resource "azurerm_network_interface" "privateip" {
#   for_each            = var.nodes
#   name                = "test-ip"
#   location            = "UK West"
#   resource_group_name = "my-first-rg"
#
#   ip_configuration {
#     name                          = "test-ip"
#     subnet_id                     = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Network/virtualNetworks/test-network/subnets/default"
#     # private_ip_address_allocation = length(each.value["private_ip_address_allocation"]) > 0 ? each.value["private_ip_address_allocation"] : "Dynamic"
#     private_ip_address_allocation = length(try(each.value["private_ip_address_allocation"], "")) > 0 ? each.value["private_ip_address_allocation"] : "Dynamic"
#   }
# }

# condition ? true_val : false_val
# Conditions in terraform are meant to pick a value, Not meant to run a resource or not

# Condition is all about picking the right hand side value of attribute or argument in terraform. We can use that as advantage to determine whether we can
# Create a resource or not with loop combinations
# Count - 0 condition ? : 0


variable "demo" {
  default = true
}

variable "demo1" {
  default = false
}

resource "null_resource" "demo" {
  count = var.demo ? 1 : 0
}

resource "null_resource" "demo1" {
  count = var.demo1 ? 1 : 0
}




