output "rg_name" {
  value = azurerm_resource_group.acr_rg.name
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "acr_login_admin_username" {
  value = azurerm_container_registry.acr.admin_username
}

output "acr_login_admin_password" {
  value = azurerm_container_registry.acr.admin_password
}