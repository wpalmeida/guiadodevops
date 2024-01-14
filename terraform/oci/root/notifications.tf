resource "oci_ons_notification_topic" "root" {
  compartment_id = var.compartment_id
  name           = var.notification_topic_name
}

resource "oci_ons_subscription" "root" {
  compartment_id = var.compartment_id
  endpoint       = var.subscription_endpoint
  protocol       = var.subscription_protocol
  topic_id       = oci_ons_notification_topic.root.id
}

