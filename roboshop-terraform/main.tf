provider "azurerm" {
  features {}
  subscription_id = "eb986b09-9743-4aa1-b10f-53da04d8708c"
}

# VIRTUAL NETWORK

resource "azurerm_virtual_network" "shared_network" {
  name                = "shared-network"
  address_space       = ["10.0.0.0/16"]
  location            = "UK West"
  resource_group_name = "my-first-rg"
}

resource "azurerm_subnet" "shared_subnet" {
  name                 = "shared-subnet"
  resource_group_name  = "my-first-rg"
  virtual_network_name = "shared-network"
  address_prefixes = ["10.0.1.0/24"]
  depends_on = [azurerm_virtual_network.shared_network]
}

resource "azurerm_subnet_network_security_group_association" "shared_nsg" {
  subnet_id = azurerm_subnet.shared_subnet.id
  network_security_group_id = azurerm_network_security_group.shared_nsg.id
}

# NETWORK SECURITY GROUP

resource "azurerm_network_security_group" "shared_nsg" {
  name                = "shared-nsg"
  location            = "UK West"
  resource_group_name = "my-first-rg"

  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-http"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-https"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
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
    subnet_id                     = azurerm_subnet.shared_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.frontend.id
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

resource "azurerm_dns_a_record" "frontend" {
  name                = "frontend-dev"
  zone_name           = "mydevops.shop"
  resource_group_name = "my-first-rg"
  ttl                 = 3
  records             = [azurerm_network_interface.frontend.private_ip_address]
}

# MONGODB

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
    subnet_id                     = azurerm_subnet.shared_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.mongodb.id
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

resource "azurerm_dns_a_record" "mongodb" {
  name                = "mongodb-dev"
  zone_name           = "mydevops.shop"
  resource_group_name = "my-first-rg"
  ttl                 = 3
  records             = [azurerm_network_interface.mongodb.private_ip_address]
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
    subnet_id                     = azurerm_subnet.shared_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.catalogue.id
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

resource "azurerm_dns_a_record" "catalogue" {
  name                = "catalogue-dev"
  zone_name           = "mydevops.shop"
  resource_group_name = "my-first-rg"
  ttl                 = 3
  records             = [azurerm_network_interface.catalogue.private_ip_address]
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
    subnet_id                     = azurerm_subnet.shared_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.redis.id
  }
}

resource "azurerm_virtual_machine" "redis" {
  name                = "redis"
  location            = "UK West"
  resource_group_name = "my-first-rg"
  network_interface_ids = [azurerm_network_interface.redis.id]
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

resource "azurerm_dns_a_record" "redis" {
  name                = "redis-dev"
  zone_name           = "mydevops.shop"
  resource_group_name = "my-first-rg"
  ttl                 = 3
  records             = [azurerm_network_interface.redis.private_ip_address]
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
    subnet_id                     = azurerm_subnet.shared_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.user.id
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

resource "azurerm_dns_a_record" "user" {
  name                = "user-dev"
  zone_name           = "mydevops.shop"
  resource_group_name = "my-first-rg"
  ttl                 = 3
  records             = [azurerm_network_interface.user.private_ip_address]
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
    subnet_id                     = azurerm_subnet.shared_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.cart.id
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

resource "azurerm_dns_a_record" "cart" {
  name                = "cart-dev"
  zone_name           = "mydevops.shop"
  resource_group_name = "my-first-rg"
  ttl                 = 3
  records             = [azurerm_network_interface.cart.private_ip_address]
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
    subnet_id                     = azurerm_subnet.shared_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.mysql.id
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

resource "azurerm_dns_a_record" "mysql" {
  name                = "mysql-dev"
  zone_name           = "mydevops.shop"
  resource_group_name = "my-first-rg"
  ttl                 = 3
  records             = [azurerm_network_interface.mysql.private_ip_address]
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
    subnet_id                     = azurerm_subnet.shared_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.shipping.id
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

resource "azurerm_dns_a_record" "shipping" {
  name                = "shipping-dev"
  zone_name           = "mydevops.shop"
  resource_group_name = "my-first-rg"
  ttl                 = 3
  records             = [azurerm_network_interface.shipping.private_ip_address]
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
    subnet_id                     = azurerm_subnet.shared_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.rabbitmq.id
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

resource "azurerm_dns_a_record" "rabbitmq" {
  name                = "rabbitmq-dev"
  zone_name           = "mydevops.shop"
  resource_group_name = "my-first-rg"
  ttl                 = 3
  records             = [azurerm_network_interface.rabbitmq.private_ip_address]
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
    subnet_id                     = azurerm_subnet.shared_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.payment.id
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

resource "azurerm_dns_a_record" "payment" {
  name                = "payment-dev"
  zone_name           = "mydevops.shop"
  resource_group_name = "my-first-rg"
  ttl                 = 3
  records             = [azurerm_network_interface.payment.private_ip_address]
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
    subnet_id                     = azurerm_subnet.shared_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.dispatch.id
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

resource "azurerm_dns_a_record" "dispatch" {
  name                = "dispatch-dev"
  zone_name           = "mydevops.shop"
  resource_group_name = "my-first-rg"
  ttl                 = 3
  records             = [azurerm_network_interface.dispatch.private_ip_address]
}