

data "tfe_agent_pool" "Test_Application_Sandbox_AgentPool" {
  name         = "Pool01"
  organization = data.tfe_organization.CNO_Financial.name

}
resource "tfe_oauth_client" "Test_Application_Sandbox_Oauth" {
  name             = "Test_Application_Sandbox_Oauth"
  organization     = data.tfe_organization.CNO_Financial.name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.cno9zl_github_token
  service_provider = "github"
}
resource "tfe_workspace" "Test_Application_Sandbox" {
  name           = "Test_Application_Sandbox"
  #organization   = local.Test_Application_Sandbox_OrgName
  organization   = data.tfe_organization.CNO_Financial.name
#  agent_pool_id  = "apool-Fc37tzKDHSZAXs5w"
  agent_pool_id  = data.tfe_agent_pool.Test_Application_Sandbox_AgentPool.id
  execution_mode = "agent"
  vcs_repo {
  identifier = "cno9zl/Test_Application_IAC"
  oauth_token_id = resource.tfe_oauth_client.Test_Application_Sandbox_Oauth.oauth_token_id
  branch = "Sandbox"
  }

   lifecycle {
   prevent_destroy = true
 }
  depends_on = [
    resource.tfe_oauth_client.Test_Application_Sandbox_Oauth
  ]
}
data "tfe_variable_set" "Test_Application_Sandbox_Cred_Variable_Set" {
  name         = "AZ_Cred_Prod"
  organization = data.tfe_organization.CNO_Financial.name
}
  resource "tfe_workspace_variable_set" "Test_Application_Sandbox_Cred_Variable_Set" {
  variable_set_id = data.tfe_variable_set.Test_Application_Sandbox_Cred_Variable_Set.id
  workspace_id    = resource.tfe_workspace.Test_Application_Sandbox.id
}
data "tfe_variable_set" "Test_Application_Sandbox_Default_Variable_Set" {
  name         = "Default_Credentials"
  organization = data.tfe_organization.CNO_Financial.name
}
  resource "tfe_workspace_variable_set" "Test_Application_Sandbox_Default_Variable_Set" {
  variable_set_id = data.tfe_variable_set.Test_Application_Sandbox_Default_Variable_Set.id
  workspace_id    = resource.tfe_workspace.Test_Application_Sandbox.id
}
resource "tfe_variable" "Test_Application_Sandbox_subscription_id" {
  key          = "subscription_id"
  value        = "b5598f65-c814-421a-af61-bf4e51ad03e0"
  category     = "terraform"
  workspace_id = resource.tfe_workspace.Test_Application_Sandbox.id
  description  = "Azure Subscription ID"
}