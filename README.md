# tf-azurerm-module-container_registry

## Overview

This terraform module creates an Azure Container Registry in the Azure portal

## Pre-Commit hooks
[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly
- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below
```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.
- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```
- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitgnore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target
- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | <= 1.5.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.77.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.89.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | name of the target resource group resource mask | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Resource Group. | `string` | n/a | yes |
| <a name="input_container_registry_name"></a> [container\_registry\_name](#input\_container\_registry\_name) | Container Registry name. | `string` | `"nexientacr000"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU name of the container registry. Possible values are Basic, Standard and Premium. | `string` | `"Basic"` | no |
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | Specifies whether the admin user is enabled. Defaults to true. When enabled, password tokens are generated to be used with docker login | `bool` | `true` | no |
| <a name="input_retention_policy"></a> [retention\_policy](#input\_retention\_policy) | Set a retention policy for untagged manifests | <pre>object({<br>    days    = optional(number)<br>    enabled = optional(bool)<br>  })</pre> | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of user managed identity ids to be assigned.<br>    This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned` | `list(string)` | `null` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | Encrypt registry using a customer-managed key | <pre>object({<br>    key_vault_key_id   = string<br>    identity_client_id = string<br>  })</pre> | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for the container registry. Defaults to true. | `bool` | `true` | no |
| <a name="input_network_rule_bypass_option"></a> [network\_rule\_bypass\_option](#input\_network\_rule\_bypass\_option) | Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are<br>    None and AzureServices. Defaults to AzureServices | `string` | `"AzureServices"` | no |
| <a name="input_zone_redundancy_enabled"></a> [zone\_redundancy\_enabled](#input\_zone\_redundancy\_enabled) | Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created.<br>    Defaults to false | `bool` | `false` | no |
| <a name="input_georeplications"></a> [georeplications](#input\_georeplications) | If specified, the ACR will be replicated to other regions specified in this block | <pre>map(object({<br>    location                  = string<br>    regional_endpoint_enabled = bool<br>    zone_redundancy_enabled   = bool<br>  }))</pre> | `{}` | no |
| <a name="input_network_rule_set"></a> [network\_rule\_set](#input\_network\_rule\_set) | Network rules to explicitly allow IP ranges<br>    CIDR ranges should be provided | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Custom tags for the  container registry | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_registry_id"></a> [container\_registry\_id](#output\_container\_registry\_id) | The ID of the Container Registry |
| <a name="output_container_registry_login_server"></a> [container\_registry\_login\_server](#output\_container\_registry\_login\_server) | The login server of the Container Registry |
| <a name="output_container_registry_name"></a> [container\_registry\_name](#output\_container\_registry\_name) | Name of the Container Registry |
| <a name="output_container_registry_admin_username"></a> [container\_registry\_admin\_username](#output\_container\_registry\_admin\_username) | The admin username of the Container Registry |
| <a name="output_container_registry_admin_password"></a> [container\_registry\_admin\_password](#output\_container\_registry\_admin\_password) | The admin password of the Container Registry |
| <a name="output_container_registry_admin_enabled"></a> [container\_registry\_admin\_enabled](#output\_container\_registry\_admin\_enabled) | The admin enable of the Container Registry |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
