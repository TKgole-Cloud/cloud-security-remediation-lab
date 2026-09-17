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