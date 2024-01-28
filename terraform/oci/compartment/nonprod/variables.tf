# General
variable "compartment_id" {
  type = string
}

variable "compartment_description" {
  type    = string
  default = "nonprod"
}

variable "compartment_name" {
  type    = string
  default = "gdd-nonprod-cpmt"
}