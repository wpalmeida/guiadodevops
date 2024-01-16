resource "oci_devops_project" "root" {
  compartment_id = var.compartment_id
  name           = var.project_name
  notification_config {
    topic_id = oci_ons_notification_topic.root.id
  }
}