locals {
  OrgName = "CNO_Financial"
  AppName = "Test_Application"
  AgtPoolId = "apool-Fc37tzKDHSZAXs5w"
  RepoId = "cno9zl/Test_Application_SIT_IAC"
  GithubToken = var.cno9zl_github_token
}

data "tfe_organization" "CNO_Financial" {
  name  = local.OrgName

}

data "tfe_agent_pool" "Test_Application_SIT_AgentPool" {
  name         = "pool01"
  organization = data.tfe_organization.CNO_Financial.name

}
resource "tfe_oauth_client" "Test_Application_SIT_Oauth" {
  name             = "Test_Application_SIT_Oauth"
  organization     = data.tfe_organization.CNO_Financial.name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.cno9zl_github_token
  service_provider = "github"
}
resource "tfe_workspace" "Test_Application_SIT" {
  name           = "Test_Application_SIT"
  #organization   = local.OrgName
  organization   = data.tfe_organization.CNO_Financial.name
#  agent_pool_id  = "apool-Fc37tzKDHSZAXs5w"
  agent_pool_id  = data.tfe_agent_pool.Test_Application_SIT_AgentPool.id
  execution_mode = "agent"
  vcs_repo {
  identifier = "cno9zl/Test_Application_SIT_IAC"
  oauth_token_id = resource.tfe_oauth_client.Test_Application_SIT_Oauth.oauth_token_id
  branch = SIT
  }

   lifecycle {
   prevent_destroy = true
 }
  depends_on = [
    resource.tfe_oauth_client.Test_Application_SIT_Oauth
  ]
}