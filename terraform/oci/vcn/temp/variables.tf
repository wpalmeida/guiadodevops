# General
variable "compartment_id" {
  type = string
}

# VCN
variable "vcn_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

# variable "vcn_cidr_blocks" {
#   type = list()
# }

variable "vcn_display_name" {
  type    = string
  default = "guiadodevops"
}

# Subnet
variable "subnet_cidr_block" {
  type    = string
  default = "10.0.0.0/24"
}

variable "subnet_display_name" {
  type    = string
  default = "endpoint"
}