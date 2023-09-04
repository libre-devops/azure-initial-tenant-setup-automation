terraform {
  #Use the latest by default, uncomment below to pin or use hcl.lck
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
    azapi = {
      source = "Azure/azapi"
    }
    azuredevops = {
      source = "microsoft/azuredevops"
    }
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
  backend "azurerm" {}
}
