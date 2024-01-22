# General

variable "compartment_id" {
  type = string
}

variable "instance_display_name" {
  type = string
  default = "vpn"
}

variable "availability_domain" {
  type = string
  default = "YCyV:SA-SAOPAULO-1-AD-1"
}

variable "shape" {
  type = string
  default = "VM.Standard.E3.Flex"
}