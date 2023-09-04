resource "azurecaf_name" "subscription" {
  name          = "mgmt"
  resource_type = "azurerm_resource_group"
  prefixes      = []
  suffixes      = [var.short, var.loc, terraform.workspace]
  random_length = 5
  clean_input   = true
}
