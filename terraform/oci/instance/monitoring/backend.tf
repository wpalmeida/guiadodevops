terraform {
  backend "azurerm" {
    resource_group_name  = "guiadodevops"
    storage_account_name = "guiadodevops"
    container_name       = "terraform"
    key                  = "oci/instance/monitoring/terraform.tfstate"
  }
}

data "terraform_remote_state" "vcn" {
  backend = "azurerm"
  config = {
    resource_group_name  = "guiadodevops"
    storage_account_name = "guiadodevops"
    container_name       = "terraform"
    key                  = "vcn/terraform.tfstate"
  }
}