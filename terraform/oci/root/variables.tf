# General
variable "compartment_id" {
  type = string
}


# Notification
variable "subscription_endpoint" {
  type = string
}

variable "subscription_protocol" {
  type = string
}

variable "notification_topic_name" {
  type = string
}

# DevOps Project
variable "project_name" {
  type = string
}