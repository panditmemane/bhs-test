terraform {

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
        resource_group_name  = "terrafromdemo"
        storage_account_name = "terrafromcodes"
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

