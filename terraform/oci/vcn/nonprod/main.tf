resource "oci_core_vcn" "vcn_nonprod" {
  compartment_id = data.terraform_remote_state.compartment.outputs.compartment_id
  cidr_block     = var.vcn_cidr_block
  display_name   = var.vcn_display_name
  dns_label      = "nonprod"
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_id
  display_name   = "igw"
  enabled        = "true"
  vcn_id         = oci_core_vcn.vcn_nonprod.id
}

resource "oci_core_subnet" "service_lb" {
  cidr_block                 = "10.0.20.0/24"
  compartment_id             = var.compartment_id
  display_name               = "service-lb"
  dns_label                  = "servicelb"
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_default_route_table.default_route_table.id
  security_list_ids          = [oci_core_security_list.service_lb.id]
  vcn_id                     = oci_core_vcn.vcn_nonprod.id
}

resource "oci_core_subnet" "node" {
  cidr_block                 = "10.0.10.0/24"
  compartment_id             = var.compartment_id
  display_name               = "node"
  dns_label                  = "node"
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_default_route_table.default_route_table.id
  security_list_ids          = [oci_core_security_list.node.id]
  vcn_id                     = oci_core_vcn.vcn_nonprod.id
}

resource "oci_core_subnet" "api_endpoint" {
  cidr_block                 = "10.0.0.0/28"
  compartment_id             = var.compartment_id
  display_name               = "api-endpoint"
  dns_label                  = "apiendpoint"
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_default_route_table.default_route_table.id
  security_list_ids          = [oci_core_security_list.api_endpoint.id]
  vcn_id                     = oci_core_vcn.vcn_nonprod.id
}

resource "oci_core_default_route_table" "default_route_table" {
  display_name = "default"
  route_rules {
    description       = "traffic to/from internet"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
  manage_default_resource_id = oci_core_vcn.vcn_nonprod.default_route_table_id
}

resource "oci_core_security_list" "service_lb" {
  compartment_id = var.compartment_id
  display_name   = "service-lb"
  vcn_id         = oci_core_vcn.vcn_nonprod.id
}

resource "oci_core_security_list" "node" {
  compartment_id = var.compartment_id
  display_name   = "node"
  egress_security_rules {
    description      = "Allow pods on one worker node to communicate with pods on other worker nodes"
    destination      = "10.0.10.0/24"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    stateless        = "false"
  }
  egress_security_rules {
    description      = "Access to Kubernetes API Endpoint"
    destination      = "10.0.0.0/28"
    destination_type = "CIDR_BLOCK"
    protocol         = "6"
    stateless        = "false"
  }
  egress_security_rules {
    description      = "Kubernetes worker to control plane communication"
    destination      = "10.0.0.0/28"
    destination_type = "CIDR_BLOCK"
    protocol         = "6"
    stateless        = "false"
  }
  egress_security_rules {
    description      = "Path discovery"
    destination      = "10.0.0.0/28"
    destination_type = "CIDR_BLOCK"
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol  = "1"
    stateless = "false"
  }
  egress_security_rules {
    description      = "Allow nodes to communicate with OKE to ensure correct start-up and continued functioning"
    destination      = "all-gru-services-in-oracle-services-network"
    destination_type = "SERVICE_CIDR_BLOCK"
    protocol         = "6"
    stateless        = "false"
  }
  egress_security_rules {
    description      = "ICMP Access from Kubernetes Control Plane"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol  = "1"
    stateless = "false"
  }
  egress_security_rules {
    description      = "Worker Nodes access to Internet"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    stateless        = "false"
  }
  ingress_security_rules {
    description = "Allow pods on one worker node to communicate with pods on other worker nodes"
    protocol    = "all"
    source      = "10.0.10.0/24"
    stateless   = "false"
  }
  ingress_security_rules {
    description = "Path discovery"
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol  = "1"
    source    = "10.0.0.0/28"
    stateless = "false"
  }
  ingress_security_rules {
    description = "TCP access from Kubernetes Control Plane"
    protocol    = "6"
    source      = "10.0.0.0/28"
    stateless   = "false"
  }
  ingress_security_rules {
    description = "Inbound SSH traffic to worker nodes"
    protocol    = "6"
    source      = "0.0.0.0/0"
    stateless   = "false"
  }
  vcn_id = oci_core_vcn.vcn_nonprod.id
}

resource "oci_core_security_list" "api_endpoint" {
  compartment_id = var.compartment_id
  display_name   = "api-endpoint"
  egress_security_rules {
    description      = "Allow Kubernetes Control Plane to communicate with OKE"
    destination      = "all-gru-services-in-oracle-services-network"
    destination_type = "SERVICE_CIDR_BLOCK"
    protocol         = "6"
    stateless        = "false"
  }
  egress_security_rules {
    description      = "All traffic to worker nodes"
    destination      = "10.0.10.0/24"
    destination_type = "CIDR_BLOCK"
    protocol         = "6"
    stateless        = "false"
  }
  egress_security_rules {
    description      = "Path discovery"
    destination      = "10.0.10.0/24"
    destination_type = "CIDR_BLOCK"
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol  = "1"
    stateless = "false"
  }
  ingress_security_rules {
    description = "External access to Kubernetes API endpoint"
    protocol    = "6"
    source      = "0.0.0.0/0"
    stateless   = "false"
  }
  ingress_security_rules {
    description = "Kubernetes worker to Kubernetes API endpoint communication"
    protocol    = "6"
    source      = "10.0.10.0/24"
    stateless   = "false"
  }
  ingress_security_rules {
    description = "Kubernetes worker to control plane communication"
    protocol    = "6"
    source      = "10.0.10.0/24"
    stateless   = "false"
  }
  ingress_security_rules {
    description = "Path discovery"
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol  = "1"
    source    = "10.0.10.0/24"
    stateless = "false"
  }
  vcn_id = oci_core_vcn.vcn_nonprod.id
}