provider "azurerm" {
  features {}
  subscription_id = "eb986b09-9743-4aa1-b10f-53da04d8708c"
}

resource "azurerm_virtual_machine" "test" {
  name                = "test-vm"
  location            = "UK West"
  resource_group_name = "my-first-rg"
  network_interface_ids = [
    "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Network/networkInterfaces/terraform-testing"
  ]
  vm_size             = "Standard_B2s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Compute/images/local-devops-practice"
  }

  storage_os_disk {
    name              = "test-vm"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "test-vm"
    admin_username = "azuser"
    admin_password = "Giveme123456"
  }
}