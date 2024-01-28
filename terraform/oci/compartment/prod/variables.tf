# General
variable "compartment_id" {
  type = string
}

variable "compartment_description" {
  type    = string
  default = "prod"
}

variable "compartment_name" {
  type    = string
  default = "gdd-prod-cpmt"
}