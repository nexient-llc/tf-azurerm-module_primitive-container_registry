#########################################
#Common variables
#########################################

variable "resource_group_name" {
  description = "name of the target resource group resource mask"
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the Resource Group."
  type        = string
}


##############################################
# Variables associated with Container Registry
##############################################
variable "container_registry_name" {
  type        = string
  description = "Container Registry name."
  default     = "nexientacr000"
}

variable "sku" {
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium."
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Specifies whether the admin user is enabled. Defaults to true. When enabled, password tokens are generated to be used with docker login"
  type        = bool
  default     = true
}

variable "retention_policy" {
  description = "Set a retention policy for untagged manifests"
  type = object({
    days    = optional(number)
    enabled = optional(bool)
  })
  default = null
}

variable "identity_ids" {
  description = <<EOT
    Specifies a list of user managed identity ids to be assigned.
    This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`
  EOT
  type        = list(string)
  default     = null
}

variable "encryption" {
  description = "Encrypt registry using a customer-managed key"
  type = object({
    key_vault_key_id   = string
    identity_client_id = string
  })
  default = null
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for the container registry. Defaults to true."
  type        = bool
  default     = true
}

variable "network_rule_bypass_option" {
  description = <<EOT
    Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are
    None and AzureServices. Defaults to AzureServices
  EOT
  type        = string
  default     = "AzureServices"
}

variable "zone_redundancy_enabled" {
  description = <<EOT
    Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created.
    Defaults to false
  EOT
  type        = bool
  default     = false
}

variable "georeplications" {
  description = "If specified, the ACR will be replicated to other regions specified in this block"
  type = map(object({
    location                  = string
    regional_endpoint_enabled = bool
    zone_redundancy_enabled   = bool
  }))

  default = {}
}

variable "network_rule_set" {
  description = <<EOT
    Network rules to explicitly allow IP ranges
    CIDR ranges should be provided
  EOT
  type        = list(string)
  default     = []
}


variable "tags" {
  description = "Custom tags for the  container registry"
  type        = map(string)
  default     = {}
}
