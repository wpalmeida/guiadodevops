resource "oci_identity_compartment" "shared_compartment" {
  compartment_id = var.compartment_id
  description    = var.compartment_description
  name           = var.compartment_name
  enable_delete  = true
  freeform_tags  = { "env" = "shared" }
}