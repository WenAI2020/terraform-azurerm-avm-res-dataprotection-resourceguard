terraform {
  required_version = ">= 1.9, < 2.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "eeed4cd0-013c-43a7-8e45-dd765abaff2c"
  # resource_provider_registrations = "all"
}

locals {
  enable_telemetry    = true
  location            = "southeastasia"
  name                = "commitregu"
  resource_group_id   = "/subscriptions/eeed4cd0-013c-43a7-8e45-dd765abaff2c/resourceGroups/firstavmrg"
  resource_group_name = "firstavmrg"
  tags = {
    scenario = "Default"
    project  = "AVM"
    delete   = "yes"
  }
  vault_critical_operation_exclusion_list = [
    "Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems/delete"
  ]
}

module "default" {
  source                                  = "../../"
  name                                    = local.name
  location                                = local.location
  vault_critical_operation_exclusion_list = local.vault_critical_operation_exclusion_list
  resource_group_name                     = local.resource_group_name
  resource_group_id                       = local.resource_group_id
  tags                                    = local.tags
}
