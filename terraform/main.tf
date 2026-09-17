terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.6.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "security_lab" {
  name     = "rg-cloud-security-lab"
  location = "South Africa North"

  tags = {
    Owner      = "Thato"
    CostCenter = "CloudSecurityLab"
    Environment = "Lab"
  }
}

resource "azurerm_storage_account" "security_lab" {
  name                     = "zembecloudsecuritylab01"
  resource_group_name      = azurerm_resource_group.security_lab.name
  location                 = azurerm_resource_group.security_lab.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = false

  tags = {
    Owner       = "Thato"
    CostCenter  = "CloudSecurityLab"
    Environment = "Lab"
  }
}

resource "azurerm_network_security_group" "security_lab" {
  name                = "nsg-cloud-security-lab"
  location            = azurerm_resource_group.security_lab.location
  resource_group_name = azurerm_resource_group.security_lab.name

  security_rule {
  name                       = "Allow-SSH-Internet"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "VirtualNetwork"
  destination_address_prefix = "*"
}

  tags = {
    Owner       = "Thato"
    CostCenter  = "CloudSecurityLab"
    Environment = "Lab"
  }
}

