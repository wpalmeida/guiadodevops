output "vcn_id" {
  value = oci_core_vcn.guiadodevops.id
}

output "service_lb_subnet_id" {
  value = oci_core_subnet.service_lb.id
}

output "node_subnet_id" {
  value = oci_core_subnet.node.id
}

output "api_endpoint_subnet_id" {
  value = oci_core_subnet.api_endpoint.id
}