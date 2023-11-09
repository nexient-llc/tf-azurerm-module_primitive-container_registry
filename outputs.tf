output "container_registry_id" {
  description = "The ID of the Container Registry"
  value       = azurerm_container_registry.acr.id
}

output "container_registry_login_server" {
  description = "The login server of the Container Registry"
  value       = azurerm_container_registry.acr.login_server
}


output "container_registry_admin_username" {
  description = "The admin username of the Container Registry"
  value       = azurerm_container_registry.acr.admin_username
  sensitive   = true
}

output "container_registry_admin_password" {
  description = "The admin password of the Container Registry"
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
}

output "container_registry_admin_enabled" {
  description = "The admin enable of the Container Registry"
  value       = azurerm_container_registry.acr.admin_enabled
  sensitive   = true
}
