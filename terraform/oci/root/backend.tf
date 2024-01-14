terraform {
  backend "s3" {
    bucket    = "terraform"
    key       = "terraform.tfstate"
    region    = "sa-saopaulo-1"
    endpoints = { s3 = "https://gr5ugxwrsywe.compat.objectstorage.sa-saopaulo-1.oraclecloud.com" }

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_metadata_api_check     = true
  }
}