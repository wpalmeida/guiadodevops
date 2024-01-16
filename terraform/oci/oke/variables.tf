# General
variable "compartment_id" {
  type = string
}

# Oke
variable "cluster_kubernetes_version" {
  type = string
  default = "v1.28.2"
}

variable "cluster_name" {
  type = string
  default = "temp"
}