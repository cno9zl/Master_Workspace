data "tfe_agent_pool" "KubTests_DEV_AgentPool" {
  name         = "Pool01"
  organization = data.tfe_organization.CNO_Financial.name

}
resource "tfe_oauth_client" "KubTests_DEV_Oauth" {
  name             = "KubTests_DEV_Oauth"
  organization     = data.tfe_organization.CNO_Financial.name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.cno9zl_github_token
  service_provider = "github"
}
resource "tfe_workspace" "KubTests_DEV" {
  name           = "KubTests_DEV"
  #organization   = local.KubTests_DEV_OrgName
  #organization   = local.KubTests_DEV_OrgName
  organization   = data.tfe_organization.CNO_Financial.name
  agent_pool_id  = data.tfe_agent_pool.KubTests_DEV_AgentPool.id
  execution_mode = "agent"
  vcs_repo {
  identifier = "cno9zl/IAC"
  oauth_token_id = resource.tfe_oauth_client.KubTests_DEV_Oauth.oauth_token_id
  branch = "KubTests_DEV"
  }

   lifecycle {
   prevent_destroy = true
 }
  depends_on = [
    resource.tfe_oauth_client.KubTests_DEV_Oauth
  ]
}

data "tfe_variable_set" "KubTests_DEV_Cred_Variable_Set" {
  name         = "AZ_Cred_Prod"
  organization = data.tfe_organization.CNO_Financial.name
}
  resource "tfe_workspace_variable_set" "KubTests_DEV_Cred_Variable_Set" {
  variable_set_id = data.tfe_variable_set.KubTests_DEV_Cred_Variable_Set.id
  workspace_id    = resource.tfe_workspace.KubTests_DEV.id
}
data "tfe_variable_set" "KubTests_DEV_Default_Variable_Set" {
  name         = "Default_Credentials"
  organization = data.tfe_organization.CNO_Financial.name
}
  resource "tfe_workspace_variable_set" "KubTests_DEV_Default_Variable_Set" {
  variable_set_id = data.tfe_variable_set.KubTests_DEV_Default_Variable_Set.id
  workspace_id    = resource.tfe_workspace.KubTests_DEV.id
}
resource "tfe_variable" "KubTests_DEV_subscription_id" {
  key          = "subscription_id"
  value        = "398b0d47-9ca7-47f8-8464-c2207e0a9c7a"
  category     = "terraform"
  workspace_id = resource.tfe_workspace.KubTests_DEV.id
  description  = "Azure Subscription ID"
}