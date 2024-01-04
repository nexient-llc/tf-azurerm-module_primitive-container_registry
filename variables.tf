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

variable "container_registry" {
  description = "Required and important input variables for the container registry"
  type = object({
    admin_enabled = bool
    sku           = string
  })

  default = {
    admin_enabled = true
    sku           = "Basic"
  }
}

variable "tags" {
  description = "Custom tags for the  container registry"
  type        = map(string)
  default     = {}
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
  description = "Specifies a list of user managed identity ids to be assigned. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`"
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
