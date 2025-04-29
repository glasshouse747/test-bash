resource "null_resource" "test" {
  count = 10
}

# Count resource attributes are referred with resourcelabel.locallabel[*]
# (* denoting all values, if we want first value then [0])

# output "test" {
#   value = null_resource.test
# }

output "test" {
  value = null_resource.test[*].id
}

resource "null_resource" "testx" {
}

output "testx" {
  value = null_resource.testx.id
}

## Count is not a great one to start for looping, as it has its own problems

provider "azurerm" {
  features {}
  subscription_id = "eb986b09-9743-4aa1-b10f-53da04d8708c"
}

variable "nodes" {
  default = [
  "test2",
  "test1"]
}

resource "azurerm_network_interface" "privateip" {
  count               = length(var.nodes)
  name                = "${var.nodes[count.index]}-ip"
  location            = "UK West"
  resource_group_name = "my-first-rg"

  ip_configuration {
    name                          = "${var.nodes[count.index]}-ip"
    subnet_id                     = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Network/virtualNetworks/test-network/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "test" {
  count               = length(var.nodes)
  name                = "${var.nodes[count.index]}-vm"
  location            = "UK West"
  resource_group_name = "my-first-rg"
  network_interface_ids = [azurerm_network_interface.privateip[count.index].id]
  vm_size             = "Standard_B2s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Compute/images/local-devops-practice"
  }
  storage_os_disk {
    name              = "${var.nodes[count.index]}-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.nodes[count.index]}-vm"
    admin_username = "azuser"
    admin_password = "Giveme123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}