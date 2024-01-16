# General
variable "compartment_id" {
  type = string
}

# VCN
variable "vcn_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

# variable "vcn_cidr_blocks" {
#   type = list()
# }