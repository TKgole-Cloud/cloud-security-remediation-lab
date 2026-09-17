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