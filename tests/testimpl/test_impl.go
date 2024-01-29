package common

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/azure"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/nexient-llc/lcaf-component-terratest-common/types"
	"github.com/stretchr/testify/assert"
)

func TestAcrComplete(t *testing.T, ctx types.TestContext) {
	t.Run("TestAlwaysSucceeds", func(t *testing.T) {
		assert.Equal(t, "foo", "foo", "Should always be the same!")
		assert.NotEqual(t, "foo", "bar", "Should never be the same!")
	})

	containerRegistryId := terraform.Output(t, ctx.TerratestTerraformOptions, "container_registry_id")
	containerRegistryName := terraform.Output(t, ctx.TerratestTerraformOptions, "container_registry_name")
	resourceGroupName := terraform.Output(t, ctx.TerratestTerraformOptions, "resource_group_name")
	resourceGroupId := terraform.Output(t, ctx.TerratestTerraformOptions, "resource_group_id")
	subscriptionId := ""
	// When cloning the skeleton to a new module, you will need to change the below test
	// to meet your needs and add any new tests that apply to your situation.
	t.Run("TestTerraformOutputs", func(t *testing.T) {

		assert.NotEmpty(t, containerRegistryId, "Container Registry ID must not be empty")
		assert.NotEmpty(t, resourceGroupId, "Resource Group ID must not be empty")
	})

	t.Run("ValidateActualInfrastructure", func(t *testing.T) {

		containerRegistryExists := azure.ContainerRegistryExists(t, containerRegistryName, resourceGroupName, subscriptionId)
		containerRegistry := azure.GetContainerRegistry(t, containerRegistryName, resourceGroupName, subscriptionId)
		fmt.Printf("SKU: %s, Location: %s, Name: %s, LoginServer: %s\n", containerRegistry.Sku.Name, *containerRegistry.Location, *containerRegistry.Name, *containerRegistry.LoginServer)
		tags := containerRegistry.Tags
		fmt.Println("Tags:")
		for k, v := range tags {
			fmt.Println(k, "value is", *v)
		}
		_, ok := tags["resource_name"]
		assert.True(t, ok, "A tag of name resource_name must exist")

		fmt.Printf("Container Registry ID: %s", containerRegistryId)
		assert.True(t, containerRegistryExists, "Container registry must exist")

	})
}
