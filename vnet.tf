resource "azurerm_resource_group" "dev-azure-rg" {
  name     = "dev-azure-rg"
  location = "East US"
}

resource "azurerm_network_security_group" "dev-azure-sg" {
  name                = "dev-azure-sg"
  location            = azurerm_resource_group.dev-azure-rg.location
  resource_group_name = azurerm_resource_group.dev-azure-rg.name
}

resource "azurerm_virtual_network" "dev-azure-vnet" {
  name                = "dev-azure-vnet"
  location            = azurerm_resource_group.dev-azure-rg.location
  resource_group_name = azurerm_resource_group.dev-azure-rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "dev-subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "dev-subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.dev-azure-sg.id
  }

  tags = {
    environment = "dev"
  }
}