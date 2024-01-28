terraform {
  backend "azurerm" {
    resource_group_name  = "guiadodevops"
    storage_account_name = "guiadodevops"
    container_name       = "terraform"
    key                  = "oci/vcn/nonprod/terraform.tfstate"
  }
}

data "terraform_remote_state" "compartment" {
  backend = "azurerm"
  config = {
    resource_group_name  = "guiadodevops"
    storage_account_name = "guiadodevops"
    container_name       = "terraform"
    key                  = "oci/compartment/nonprod/terraform.tfstate"
  }
}