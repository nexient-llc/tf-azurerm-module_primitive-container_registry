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

resource "random_integer" "priority" {
  min = 10000
  max = 50000
}

module "resource_group" {
  source = "git::https://github.com/nexient-llc/tf-azurerm-module-resource_group.git?ref=0.2.0"

  name       = local.resource_group_name
  location   = var.location
  tags       = local.tags
  managed_by = var.managed_by
}

module "container_registry" {
  depends_on              = [module.resource_group]
  source                  = "../../"
  container_registry_name = local.name
  resource_group_name     = local.resource_group_name
  location                = var.location
  container_registry = {
    admin_enabled = var.container_registry.admin_enabled
    sku           = var.container_registry.sku
  }
}
