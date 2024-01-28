terraform {
  backend "azurerm" {
    resource_group_name  = "guiadodevops"
    storage_account_name = "guiadodevops"
    container_name       = "terraform"
    key                  = "oci/vcn/prod/terraform.tfstate"
  }
}

data "terraform_remote_state" "compartment" {
  backend = "azurerm"
  config = {
    resource_group_name  = "guiadodevops"
    storage_account_name = "guiadodevops"
    container_name       = "terraform"
    key                  = "oci/compartment/prod/terraform.tfstate"
  }
}