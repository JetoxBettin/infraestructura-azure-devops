provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg_prueba_tecnica" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet_prueba_tecnica" {
  name                = "vnet-prueba-tecnica"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet_prueba_tecnica" {
  name                 = "subnet-prueba-tecnica"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_prueba_tecnica.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "public_ip_prueba_tecnica" {
  name                = "pip-prueba-tecnica"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "nsg_prueba_tecnica" {
  name                = "nsg-prueba-tecnica"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "nic_prueba_tecnica" {
  name                = "nic-prueba-tecnica"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_prueba_tecnica.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_prueba_tecnica.id
  }
}

resource "azurerm_virtual_machine" "vm_prueba_tecnica" {
  name                  = "vm-prueba-tecnica"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic_prueba_tecnica.id]
  vm_size               = var.vm_size

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk-prueba-tecnica"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "vm-prueba-tecnica"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}