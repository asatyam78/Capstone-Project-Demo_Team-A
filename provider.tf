terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.27"
    }
  }

  required_version = ">= 0.14"
}

provider "azurerm" {
  features {}
}
