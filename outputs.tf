output "container_registry" {
  value     = azurerm_container_registry.acr
  sensitive = true
}

output "container_registry_id" {
  description = "The ID of the Container Registry"
  value       = azurerm_container_registry.acr.id
}
