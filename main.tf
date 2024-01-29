resource "azurerm_container_registry" "acr" {
  name                          = var.container_registry_name
  admin_enabled                 = var.admin_enabled
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "retention_policy" {
    for_each = var.retention_policy != null ? [var.retention_policy] : []
    content {
      days    = lookup(retention_policy.value, "days", 7)
      enabled = lookup(retention_policy.value, "enabled", true)
    }
  }

  identity {
    type         = var.identity_ids != null ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = var.identity_ids
  }

  dynamic "encryption" {
    for_each = var.encryption != null ? [var.encryption] : []
    content {
      enabled            = true
      key_vault_key_id   = encryption.value.key_vault_key_id
      identity_client_id = encryption.value.identity_client_id
    }
  }

  network_rule_bypass_option = var.network_rule_bypass_option
  zone_redundancy_enabled    = var.zone_redundancy_enabled

  dynamic "georeplications" {
    for_each = var.georeplications
    content {
      location                  = georeplications.value.location
      regional_endpoint_enabled = georeplications.value.regional_endpoint_enabled
      zone_redundancy_enabled   = georeplications.value.zone_redundancy_enabled
    }
  }

  dynamic "network_rule_set" {
    for_each = length(var.network_rule_set) > 0 && var.sku == "Premium" ? [1] : []
    content {
      default_action = "Allow"
      dynamic "ip_rule" {
        for_each = var.network_rule_set
        content {
          action   = "Allow"
          ip_range = ip_rule.value
        }
      }
    }
  }

  tags = local.tags

}
