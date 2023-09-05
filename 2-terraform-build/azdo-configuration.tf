resource "azuredevops_project" "libredevops" {
  name               = "libredevops"
  visibility         = "public"
  version_control    = "Git"
  work_item_template = "Agile"
  description        = "Managed by Terraform - Last Terraform Run: ${local.dynamic_tags.LastUpdated}"
  features = {
    "boards"       = "enabled"
    "repositories" = "enabled"
    "pipelines"    = "enabled"
    "testplans"    = "disabled"
    "artifacts"    = "enabled"
  }
}

resource "azuredevops_serviceendpoint_azurerm" "mi" {
  project_id                             = azuredevops_project.libredevops.id
  service_endpoint_name                  = data.azurerm_user_assigned_identity.mi.name
  service_endpoint_authentication_scheme = "ManagedServiceIdentity"
  azurerm_spn_tenantid                   = data.azurerm_client_config.current.tenant_id
  azurerm_subscription_id                = data.azurerm_client_config.current.subscription_id
  azurerm_subscription_name              = data.azurerm_subscription.current.display_name
}

resource "azuredevops_serviceendpoint_azurerm" "svp_subscription" {
  project_id                             = azuredevops_project.libredevops.id
  service_endpoint_name                  = data.azuread_application.mgmt_svp.display_name
  description                            = "Managed by Terraform - Last Terraform Run: ${local.dynamic_tags.LastUpdated}"
  service_endpoint_authentication_scheme = "ServicePrincipal"
  credentials {
    serviceprincipalid  = data.azurerm_key_vault_secret.svp_client_id.value
    serviceprincipalkey = data.azurerm_key_vault_secret.svp_client_secret.value
  }
  azurerm_spn_tenantid      = data.azurerm_client_config.current.tenant_id
  azurerm_subscription_id   = data.azurerm_client_config.current.subscription_id
  azurerm_subscription_name = data.azurerm_subscription.current.display_name
}

resource "azuredevops_variable_group" "mgmt_kv" {
  project_id   = azuredevops_project.libredevops.id
  name         = data.azurerm_key_vault.mgmt_kv.name
  description  = "Managed by Terraform - Last Terraform Run: ${local.dynamic_tags.LastUpdated}"
  allow_access = true

  key_vault {
    name                = data.azurerm_key_vault.mgmt_kv.name
    service_endpoint_id = azuredevops_serviceendpoint_azurerm.svp_subscription.id
    search_depth        = 50
  }

  dynamic "variable" {
    for_each = toset(data.azurerm_key_vault_secrets.kv_secrets.names)
    content {
      name = variable.key
    }
  }
}

resource "azuredevops_agent_pool" "windows" {
  name           = "${var.short}-prd-windows"
  auto_provision = true
  auto_update    = true
}

resource "azuredevops_agent_pool" "linux" {
  name           = "${var.short}-prd-linux"
  auto_provision = true
  auto_update    = true
}
