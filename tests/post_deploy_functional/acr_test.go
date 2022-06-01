package test

// Basic imports
import (
	"path"
	"testing"

	"github.com/gruntwork-io/terratest/modules/files"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/suite"
)

// Define the suite, and absorb the built-in basic suite
// functionality from testify - including a T() method which
// returns the current testing context
type TerraTestSuite struct {
	suite.Suite
	TerraformOptions *terraform.Options
}

// setup to do before any test runs
func (suite *TerraTestSuite) SetupSuite() {
	tempTestFolder := test_structure.CopyTerraformFolderToTemp(suite.T(), "../..", ".")
	_ = files.CopyFile(path.Join("..", "..", ".tool-versions"), path.Join(tempTestFolder, ".tool-versions"))
	suite.TerraformOptions = terraform.WithDefaultRetryableErrors(suite.T(), &terraform.Options{
		TerraformDir: tempTestFolder,
	})
	terraform.InitAndApplyAndIdempotent(suite.T(), suite.TerraformOptions)
}

// TearDownAllSuite has a TearDownSuite method, which will run after all the tests in the suite have been run.
func (suite *TerraTestSuite) TearDownSuite() {
	terraform.Destroy(suite.T(), suite.TerraformOptions)
}

// In order for 'go test' to run this suite, we need to create
// a normal test function and pass our suite to suite.Run
func TestRunSuite(t *testing.T) {
	suite.Run(t, new(TerraTestSuite))
}

// All methods that begin with "Test" are run as tests within a suite.
func (suite *TerraTestSuite) TestOutput() {

	type ContainerRegisty struct {
		AdminEnabled         bool   `json:"admin_enabled"`
		AdminPassword        string `json:"admin_password"`
		AdminUsername        string `json:"admin_username"`
		AnonymousPullEnabled bool   `json:"anonymous_pull_enabled"`
		DataEndpointEnabled  bool   `json:"data_endpoint_enabled"`
		Encryption           []struct {
			Enabled          bool   `json:"enabled"`
			IdentityClientID string `json:"identity_client_id"`
			KeyVaultKeyID    string `json:"key_vault_key_id"`
		} `json:"encryption"`
		ExportPolicyEnabled        bool          `json:"export_policy_enabled"`
		Georeplications            []interface{} `json:"georeplications"`
		ID                         string        `json:"id"`
		Identity                   []interface{} `json:"identity"`
		Location                   string        `json:"location"`
		LoginServer                string        `json:"login_server"`
		Name                       string        `json:"name"`
		NetworkRuleBypassOption    string        `json:"network_rule_bypass_option"`
		NetworkRuleSet             []interface{} `json:"network_rule_set"`
		PublicNetworkAccessEnabled bool          `json:"public_network_access_enabled"`
		QuarantinePolicyEnabled    bool          `json:"quarantine_policy_enabled"`
		ResourceGroupName          string        `json:"resource_group_name"`
		RetentionPolicy            []struct {
			Days    int  `json:"days"`
			Enabled bool `json:"enabled"`
		} `json:"retention_policy"`
		Sku  string `json:"sku"`
		Tags struct {
			Provisioner string `json:"provisioner"`
		} `json:"tags"`
		Timeouts    interface{} `json:"timeouts"`
		TrustPolicy []struct {
			Enabled bool `json:"enabled"`
		} `json:"trust_policy"`
		ZoneRedundancyEnabled bool `json:"zone_redundancy_enabled"`
	}
	var container_registry ContainerRegisty
	terraform.OutputStruct(suite.T(), suite.TerraformOptions, "container_registry", &container_registry)
	suite.Equal(container_registry.AdminUsername, "nexientacr000")
	suite.Equal(container_registry.AdminEnabled, true)
	// Below is not working. My code gets hung
	// containerRegistryExists := azure.ContainerRegistryExists(suite.T(), "nexientacr000", "deb-test-devops", "5d26bcb0-7db7-41ce-ba3f-f6ae4744d331")
	// suite.Equal(containerRegistryExists, true)
}
