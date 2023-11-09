// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

variable "location" {
  description = "(Required) The Azure Region where the Resource Group exist. Changing this forces a new Resource Group to be created."
  type        = string
  default     = "EastUS"
}

variable "tags" {
  description = "(Optional) A mapping of tags which should be assigned to the Storage Account."
  type        = map(string)
  default     = {}
}

variable "naming_prefix" {
  description = "Prefix for the provisioned resources."
  type        = string
  default     = "platform"
}

variable "managed_by" {
  description = "(Optional) The ID of the resource that manages this resource group."
  type        = string
  default     = null

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

variable "retention_policy" {
  description = "Set a retention policy for untagged manifests"
  type = object({
    days    = optional(number)
    enabled = optional(bool)
  })
  default = {
    days    = 1
    enabled = true
  }
}
