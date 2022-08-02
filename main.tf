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
    subscription_id = "d8001963-4d58-4b89-a56f-3db63f96cbe6"
    client_id       = "09f68dcb-3b89-49d6-becd-452b2bcfa41a"
    client_secret   = "JE78Q~~wQxEDguXLElZL2d-53Ynk7NxaLjOPgdd_"
    tenant_id       = "4c6daf9f-820a-4a2a-99c5-1e27564c397e"
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
