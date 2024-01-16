terraform {
  backend "azurerm" {
    resource_group_name  = "guiadodevops"
    storage_account_name = "guiadodevops"
    container_name       = "terraform"
    key                  = "root/terraform.tfstate"
  }
}

# data "terraform_remote_state" "vnet" {
#   backend = "azurerm"
#   config = {
#     resource_group_name  = "rg-tfstate-dev-001"
#     storage_account_name = "stacccoretfstate001"
#     container_name       = "stcontainercoretfstate001"
#     key                  = "vnet/terraform.tfstate"
#   }
# }