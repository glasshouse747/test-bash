provider "azurerm" {
  features {}
  subscription_id = "eb986b09-9743-4aa1-b10f-53da04d8708c"
}

# FRONTEND

resource "azurerm_public_ip" "frontend" {
  name                = "frontend-ip"
  resource_group_name = "my-first-rg"
  location            = "UK West"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "frontend" {
  name                = "frontend-nic"
  location            = "UK West"
  resource_group_name = "my-first-rg"

  ip_configuration {
    name                          = "frontend"
    subnet_id                     = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Network/virtualNetworks/test-network/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "frontend" {
  name                = "frontend"
  location            = "UK West"
  resource_group_name = "my-first-rg"
  network_interface_ids = [azurerm_network_interface.frontend.id]
  vm_size             = "Standard_B2s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Compute/images/local-devops-practice"
  }
  storage_os_disk {
    name              = "frontend-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "frontend"
    admin_username = "azuser"
    admin_password = "Giveme123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# MONGDB

resource "azurerm_public_ip" "mongodb" {
  name                = "mongodb-ip"
  resource_group_name = "my-first-rg"
  location            = "UK West"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "mongodb" {
  name                = "mongodb-nic"
  location            = "UK West"
  resource_group_name = "my-first-rg"

  ip_configuration {
    name                          = "mongodb"
    subnet_id                     = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Network/virtualNetworks/test-network/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "mongodb" {
  name                = "mongodb"
  location            = "UK West"
  resource_group_name = "my-first-rg"
  network_interface_ids = [azurerm_network_interface.mongodb.id]
  vm_size             = "Standard_B2s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Compute/images/local-devops-practice"
  }
  storage_os_disk {
    name              = "mongodb-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "mongodb"
    admin_username = "azuser"
    admin_password = "Giveme123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# CATALOGUE

resource "azurerm_public_ip" "catalogue" {
  name                = "catalogue-ip"
  resource_group_name = "my-first-rg"
  location            = "UK West"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "catalogue" {
  name                = "catalogue-nic"
  location            = "UK West"
  resource_group_name = "my-first-rg"

  ip_configuration {
    name                          = "catalogue"
    subnet_id                     = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Network/virtualNetworks/test-network/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "catalogue" {
  name                = "catalogue"
  location            = "UK West"
  resource_group_name = "my-first-rg"
  network_interface_ids = [azurerm_network_interface.catalogue.id]
  vm_size             = "Standard_B2s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Compute/images/local-devops-practice"
  }
  storage_os_disk {
    name              = "catalogue-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "catalogue"
    admin_username = "azuser"
    admin_password = "Giveme123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}


# REDIS

resource "azurerm_public_ip" "redis" {
  name                = "redis-ip"
  resource_group_name = "my-first-rg"
  location            = "UK West"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "redis" {
  name                = "redis-nic"
  location            = "UK West"
  resource_group_name = "my-first-rg"

  ip_configuration {
    name                          = "redis"
    subnet_id                     = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Network/virtualNetworks/test-network/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "redis" {
  name                = "redis"
  location            = "UK West"
  resource_group_name = "my-first-rg"
  network_interface_ids = [azurerm_network_interface.catalogue.id]
  vm_size             = "Standard_B2s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Compute/images/local-devops-practice"
  }
  storage_os_disk {
    name              = "redis-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "redis"
    admin_username = "azuser"
    admin_password = "Giveme123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}


# USER

resource "azurerm_public_ip" "user" {
  name                = "user-ip"
  resource_group_name = "my-first-rg"
  location            = "UK West"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "user" {
  name                = "user-nic"
  location            = "UK West"
  resource_group_name = "my-first-rg"

  ip_configuration {
    name                          = "user"
    subnet_id                     = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Network/virtualNetworks/test-network/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "user" {
  name                = "user"
  location            = "UK West"
  resource_group_name = "my-first-rg"
  network_interface_ids = [azurerm_network_interface.user.id]
  vm_size             = "Standard_B2s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Compute/images/local-devops-practice"
  }
  storage_os_disk {
    name              = "user-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "user"
    admin_username = "azuser"
    admin_password = "Giveme123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}


# CART

resource "azurerm_public_ip" "cart" {
  name                = "cart-ip"
  resource_group_name = "my-first-rg"
  location            = "UK West"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "cart" {
  name                = "cart-nic"
  location            = "UK West"
  resource_group_name = "my-first-rg"

  ip_configuration {
    name                          = "cart"
    subnet_id                     = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Network/virtualNetworks/test-network/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "cart" {
  name                = "cart"
  location            = "UK West"
  resource_group_name = "my-first-rg"
  network_interface_ids = [azurerm_network_interface.cart.id]
  vm_size             = "Standard_B2s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Compute/images/local-devops-practice"
  }
  storage_os_disk {
    name              = "cart-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "cart"
    admin_username = "azuser"
    admin_password = "Giveme123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# MYSQL

resource "azurerm_public_ip" "mysql" {
  name                = "mysql-ip"
  resource_group_name = "my-first-rg"
  location            = "UK West"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "mysql" {
  name                = "mysql-nic"
  location            = "UK West"
  resource_group_name = "my-first-rg"

  ip_configuration {
    name                          = "mysql"
    subnet_id                     = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Network/virtualNetworks/test-network/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "mysql" {
  name                = "mysql"
  location            = "UK West"
  resource_group_name = "my-first-rg"
  network_interface_ids = [azurerm_network_interface.mysql.id]
  vm_size             = "Standard_B2s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Compute/images/local-devops-practice"
  }
  storage_os_disk {
    name              = "mysql-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "mysql"
    admin_username = "azuser"
    admin_password = "Giveme123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}


# SHIPPING

resource "azurerm_public_ip" "shipping" {
  name                = "shipping-ip"
  resource_group_name = "my-first-rg"
  location            = "UK West"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "shipping" {
  name                = "shipping-nic"
  location            = "UK West"
  resource_group_name = "my-first-rg"

  ip_configuration {
    name                          = "shipping"
    subnet_id                     = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Network/virtualNetworks/test-network/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "shipping" {
  name                = "shipping"
  location            = "UK West"
  resource_group_name = "my-first-rg"
  network_interface_ids = [azurerm_network_interface.shipping.id]
  vm_size             = "Standard_B2s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Compute/images/local-devops-practice"
  }
  storage_os_disk {
    name              = "shipping-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "shipping"
    admin_username = "azuser"
    admin_password = "Giveme123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}


# RABBITMQ

resource "azurerm_public_ip" "rabbitmq" {
  name                = "rabbitmq-ip"
  resource_group_name = "my-first-rg"
  location            = "UK West"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "rabbitmq" {
  name                = "rabbitmq-nic"
  location            = "UK West"
  resource_group_name = "my-first-rg"

  ip_configuration {
    name                          = "rabbitmq"
    subnet_id                     = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Network/virtualNetworks/test-network/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "rabbitmq" {
  name                = "rabbitmq"
  location            = "UK West"
  resource_group_name = "my-first-rg"
  network_interface_ids = [azurerm_network_interface.rabbitmq.id]
  vm_size             = "Standard_B2s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Compute/images/local-devops-practice"
  }
  storage_os_disk {
    name              = "rabbitmq-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "rabbitmq"
    admin_username = "azuser"
    admin_password = "Giveme123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# PAYMENT

resource "azurerm_public_ip" "payment" {
  name                = "payment-ip"
  resource_group_name = "my-first-rg"
  location            = "UK West"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "payment" {
  name                = "payment-nic"
  location            = "UK West"
  resource_group_name = "my-first-rg"

  ip_configuration {
    name                          = "payment"
    subnet_id                     = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Network/virtualNetworks/test-network/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "payment" {
  name                = "payment"
  location            = "UK West"
  resource_group_name = "my-first-rg"
  network_interface_ids = [azurerm_network_interface.payment.id]
  vm_size             = "Standard_B2s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Compute/images/local-devops-practice"
  }
  storage_os_disk {
    name              = "payment-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "payment"
    admin_username = "azuser"
    admin_password = "Giveme123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# DISPATCH

resource "azurerm_public_ip" "dispatch" {
  name                = "dispatch-ip"
  resource_group_name = "my-first-rg"
  location            = "UK West"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "dispatch" {
  name                = "dispatch-nic"
  location            = "UK West"
  resource_group_name = "my-first-rg"

  ip_configuration {
    name                          = "dispatch"
    subnet_id                     = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Network/virtualNetworks/test-network/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "dispatch" {
  name                = "dispatch"
  location            = "UK West"
  resource_group_name = "my-first-rg"
  network_interface_ids = [azurerm_network_interface.dispatch.id]
  vm_size             = "Standard_B2s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    id = "/subscriptions/eb986b09-9743-4aa1-b10f-53da04d8708c/resourceGroups/my-first-rg/providers/Microsoft.Compute/images/local-devops-practice"
  }
  storage_os_disk {
    name              = "dispatch-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "dispatch"
    admin_username = "azuser"
    admin_password = "Giveme123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}