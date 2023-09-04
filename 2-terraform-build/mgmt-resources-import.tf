#resource "azurerm_resource_group" "mgmt_rg" {
#  name     = "rg-${var.short}-${var.loc}-prd-mgmt"
#  location = local.location
#  tags     = local.tags
#}
#
#resource "azurerm_user_assigned_identity" "mgmt_id" {
#  name                = "id-${var.short}-${var.loc}-prd-mgmt-01"
#  resource_group_name = azurerm_resource_group.mgmt_rg.name
#  location            = azurerm_resource_group.mgmt_rg.location
#  tags                = azurerm_resource_group.mgmt_rg.tags
#}
#
#
