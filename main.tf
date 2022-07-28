locals {
  OrgName = "CNO_Financial"
  AppName = "Test_Application"
  AgtPoolId = "apool-Fc37tzKDHSZAXs5w"
  RepoId = "cno9zl/Test_Application_UAT_IAC"
  GithubToken = var.cno9zl_github_token
}
terraform {

  cloud {
    organization = "CNO_Financial"

    workspaces {
      name = "Master_Workspace"
#      execution-mode = "agent"
#      agent-pool-id = ""
#      vcs-repo {
#        identifier = "cno9zl/Test_Application_2_IAC"
#        oauth-token-id = var.cno9zl_github_token
#      }
    }
  }
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
      }
    }
  }