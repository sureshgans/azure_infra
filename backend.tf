terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-file-rg"
    storage_account_name = "devops032022sa"
    container_name       = "tfstate"
    key                  = "infra.tfstate"
  }
}

data "terraform_remote_state" "rg" {
  backend = "azurerm"

  config = {
    resource_group_name  = "terraform-state-file-rg"
    storage_account_name = "devops032022sa"
    container_name       = "tfstate"
    key                  = "rg.tfstate"
  }
}
