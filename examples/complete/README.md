<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | git::https://github.com/nexient-llc/tf-azurerm-module-resource_group.git | 0.2.0 |
| <a name="module_container_registry"></a> [container\_registry](#module\_container\_registry) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [random_integer.priority](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Resource Group exist. Changing this forces a new Resource Group to be created. | `string` | `"EastUS"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to the Storage Account. | `map(string)` | `{}` | no |
| <a name="input_naming_prefix"></a> [naming\_prefix](#input\_naming\_prefix) | Prefix for the provisioned resources. | `string` | `"platform"` | no |
| <a name="input_managed_by"></a> [managed\_by](#input\_managed\_by) | (Optional) The ID of the resource that manages this resource group. | `string` | `null` | no |
| <a name="input_container_registry"></a> [container\_registry](#input\_container\_registry) | Required and important input variables for the container registry | <pre>object({<br>    admin_enabled = bool<br>    sku           = string<br>  })</pre> | <pre>{<br>  "admin_enabled": true,<br>  "sku": "Basic"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_registry_id"></a> [container\_registry\_id](#output\_container\_registry\_id) | The id of the Container Registry |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
