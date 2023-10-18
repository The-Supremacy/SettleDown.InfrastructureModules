resource "azurerm_resource_group" "acr_rg" {
  name     = "rg-settledown-acr-shd-ne-001"
  location = "North Europe"
  tags = var.tags
}

resource "azurerm_container_registry" "acr" {
  name                          = "crssdshdne001"
  resource_group_name           = azurerm_resource_group.acr_rg.name
  location                      = azurerm_resource_group.acr_rg.location
  sku                           = "Basic"
  admin_enabled                 = true
  public_network_access_enabled = true
  tags = var.tags
  depends_on = [
    azurerm_resource_group.acr_rg
  ]
  lifecycle {
    prevent_destroy = true
  }
}

data "azuread_service_principal" "cicdprincipal" {
  display_name = var.azure_cicd_sp_name
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = data.azuread_service_principal.cicdprincipal.id
}

resource "azurerm_role_assignment" "acr_push" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPush"
  principal_id         = data.azuread_service_principal.cicdprincipal.id
}