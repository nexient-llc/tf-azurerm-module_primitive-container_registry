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
