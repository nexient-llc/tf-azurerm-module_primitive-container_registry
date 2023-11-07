resource "azurerm_container_registry" "acr" {
  name                = var.container_registry_name
  admin_enabled       = var.container_registry.admin_enabled
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.container_registry.sku
  tags                = local.tags
}
