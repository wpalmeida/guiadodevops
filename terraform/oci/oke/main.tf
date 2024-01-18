resource "oci_containerengine_cluster" "guiadodevops" {
    #Required
    compartment_id = var.compartment_id
    kubernetes_version = var.cluster_kubernetes_version
    name = var.cluster_name
    vcn_id = data.terraform_remote_state.vcn.outputs.vcn_id

    cluster_pod_network_options {
        cni_type = var.cluster_cluster_pod_network_options_cni_type
    }
    type = var.cluster_type
	endpoint_config {
		is_public_ip_enabled = "true"
		subnet_id = data.terraform_remote_state.vcn.outputs.api_endpoint_subnet_id
	}
	options {
		kubernetes_network_config {
			pods_cidr = "10.244.0.0/16"
			services_cidr = "10.96.0.0/16"
		}
		persistent_volume_config {
		}
		service_lb_config {
		}
		service_lb_subnet_ids = [data.terraform_remote_state.vcn.outputs.service_lb_subnet_id]
	}
}

resource "oci_containerengine_node_pool" "default" {
	cluster_id = oci_containerengine_cluster.guiadodevops.id
	compartment_id = var.compartment_id
	initial_node_labels {
		key = "name"
		value = "default"
	}
	kubernetes_version = "v1.28.2"
	name = "defaul"
	node_config_details {
		node_pool_pod_network_option_details {
			cni_type = "FLANNEL_OVERLAY"
			max_pods_per_node = "31"
		}
		placement_configs {
			availability_domain = "YCyV:SA-SAOPAULO-1-AD-1"
			fault_domains = ["FAULT-DOMAIN-2"]
			subnet_id = data.terraform_remote_state.vcn.outputs.node_subnet_id
		}
		size = "1"
	}
	node_eviction_node_pool_settings {
		eviction_grace_duration = "PT60M"
		is_force_delete_after_grace_duration = "false"
	}
	node_shape = "VM.Standard.E3.Flex"
	node_shape_config {
		memory_in_gbs = "16"
		ocpus = "1"
	}
	node_source_details {
		image_id = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaatmopjcmy2gp3725id6op5gdknjyykjnd7u7vdtq2tgtnn7xclioa"
		source_type = "IMAGE"
	}
}