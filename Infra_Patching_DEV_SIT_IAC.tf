

data "tfe_agent_pool" "Infra_Patching_DEV_SIT_AgentPool" {
  name         = "Pool01"
  organization = data.tfe_organization.CNO_Financial.name

}
resource "tfe_oauth_client" "Infra_Patching_DEV_SIT_Oauth" {
  name             = "Infra_Patching_DEV_SIT_Oauth"
  organization     = data.tfe_organization.CNO_Financial.name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.cno9zl_github_token
  service_provider = "github"
}
resource "tfe_workspace" "Infra_Patching_DEV_SIT" {
  name           = "Infra_Patching_DEV_SIT"
  #organization   = local.Infra_Patching_DEV_SIT_OrgName
  #organization   = local.Infra_Patching_DEV_SIT_OrgName
  organization   = data.tfe_organization.CNO_Financial.name
  agent_pool_id  = data.tfe_agent_pool.Infra_Patching_DEV_SIT_AgentPool.id
  execution_mode = "agent"
  vcs_repo {
  identifier = "cno9zl/IAC"
  oauth_token_id = resource.tfe_oauth_client.Infra_Patching_DEV_SIT_Oauth.oauth_token_id
  branch = "Infra_Patching_DEV_SIT"
  }

   lifecycle {
   prevent_destroy = true
 }
  depends_on = [
    resource.tfe_oauth_client.Infra_Patching_DEV_SIT_Oauth
  ]
}
data "tfe_variable_set" "Infra_Patching_DEV_SIT_Cred_Variable_Set" {
  name         = "AZ_Cred_Prod"
  organization = data.tfe_organization.CNO_Financial.name
}
  resource "tfe_workspace_variable_set" "Infra_Patching_DEV_SIT_Cred_Variable_Set" {
  variable_set_id = data.tfe_variable_set.Infra_Patching_DEV_SIT_Cred_Variable_Set.id
  workspace_id    = resource.tfe_workspace.Infra_Patching_DEV_SIT.id
}
data "tfe_variable_set" "Infra_Patching_DEV_SIT_Default_Variable_Set" {
  name         = "Default_Credentials"
  organization = data.tfe_organization.CNO_Financial.name
}
  resource "tfe_workspace_variable_set" "Infra_Patching_DEV_SIT_Default_Variable_Set" {
  variable_set_id = data.tfe_variable_set.Infra_Patching_DEV_SIT_Default_Variable_Set.id
  workspace_id    = resource.tfe_workspace.Infra_Patching_DEV_SIT.id
}
resource "tfe_variable" "Infra_Patching_DEV_SIT_subscription_id" {
  key          = "subscription_id"
  value        = "b5598f65-c814-421a-af61-bf4e51ad03e0"
  category     = "terraform"
  workspace_id = resource.tfe_workspace.Infra_Patching_DEV_SIT.id
  description  = "Azure Subscription ID"
}