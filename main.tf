terraform {

  cloud {
    organization = "CNO_Financial"

    workspaces {
      name = "Master_Workspace"
    }
  }
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
      }
    }
  }
data "tfe_organization" "CNO_Financial" {
  name  = "CNO_Financial"

}