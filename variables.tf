#########################################
#Common variables
#########################################

variable "resource_group" {
  description = "target resource group resource mask"
  type = object({
    name     = string
    location = string
  })
  default = {
    name = "deb-test-devops"
    location = "eastus"
  }
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
    admin_enabled     = bool
    sku               = string
    custom_tags       = map(string)
  })

  default = {
    admin_enabled   = true
    sku             = "Basic"
    custom_tags     = {}
  }
}
