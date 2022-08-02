terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
      backend "azurerm" {
        resource_group_name  = "terrafromdemo1"
        storage_account_name = "terrafromdemo121zc0"
        container_name       = "tfstatefiles"
        key                  = "terraform.tfstate"
    }
}

provider "azurerm" {
  features {}
}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "terrafromdemo1" {
  name     = "terrafromdemo1"
  location = "East US"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "terrafromdemo1${random_string.resource_code.result}"
  resource_group_name      = azurerm_resource_group.terrafromdemo1.name
  location                 = azurerm_resource_group.terrafromdemo1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "terrafromdemo1" {
  name                  = "tfstatefiles"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "blob"
}
