# General
variable "compartment_id" {
  type = string
}

variable "compartment_description" {
  type    = string
  default = "shared"
}

variable "compartment_name" {
  type    = string
  default = "gdd-shared-cpmt"
}