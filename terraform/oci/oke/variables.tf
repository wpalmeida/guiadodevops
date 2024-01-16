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
  default = "guiadodevops"
}

variable "cluster_cluster_pod_network_options_cni_type" {
  type = string
  default = "FLANNEL_OVERLAY"
}

variable "cluster_type" {
  type = string
  default = "BASIC_CLUSTER"
}