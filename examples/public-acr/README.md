# Complete example of Public ACR

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
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | git::https://github.com/nexient-llc/tf-module-resource_name.git | 1.0.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | git::https://github.com/nexient-llc/tf-azurerm-module_primitive-resource_group.git | 0.2.0 |
| <a name="module_container_registry"></a> [container\_registry](#module\_container\_registry) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [random_integer.priority](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_product_family"></a> [product\_family](#input\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"dso"` | no |
| <a name="input_product_service"></a> [product\_service](#input\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"kube"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. | `string` | `"dev"` | no |
| <a name="input_environment_number"></a> [environment\_number](#input\_environment\_number) | The environment count for the respective environment. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region in which the infra needs to be provisioned | `string` | `"eastus"` | no |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-module-resource\_name to generate resource names | <pre>map(object(<br>    {<br>      name       = string<br>      max_length = optional(number, 60)<br>    }<br>  ))</pre> | <pre>{<br>  "acr": {<br>    "max_length": 60,<br>    "name": "acr"<br>  },<br>  "rg": {<br>    "max_length": 60,<br>    "name": "rg"<br>  }<br>}</pre> | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU name of the container registry. Possible values are Basic, Standard and Premium. | `string` | `"Basic"` | no |
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | Specifies whether the admin user is enabled. Defaults to true. When enabled, password tokens are generated to be used with docker login | `bool` | `true` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for the container registry. Defaults to true. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the  container registry | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_registry_id"></a> [container\_registry\_id](#output\_container\_registry\_id) | The id of the Container Registry |
| <a name="output_container_registry_name"></a> [container\_registry\_name](#output\_container\_registry\_name) | n/a |
| <a name="output_acr_server_name"></a> [acr\_server\_name](#output\_acr\_server\_name) | n/a |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
