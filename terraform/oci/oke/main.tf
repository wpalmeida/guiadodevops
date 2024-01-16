resource "oci_containerengine_cluster" "test_cluster" {
    #Required
    compartment_id = var.compartment_id
    kubernetes_version = var.cluster_kubernetes_version
    name = var.cluster_name
    vcn_id = data.terraform_remote_state.vcn.outputs.vcn_id

    # #Optional
    # cluster_pod_network_options {
    #     #Required
    #     cni_type = var.cluster_cluster_pod_network_options_cni_type
    # }
    # defined_tags = {"Operations.CostCenter"= "42"}
    # endpoint_config {

    #     #Optional
    #     is_public_ip_enabled = var.cluster_endpoint_config_is_public_ip_enabled
    #     nsg_ids = var.cluster_endpoint_config_nsg_ids
    #     subnet_id = oci_core_subnet.test_subnet.id
    # }
    # freeform_tags = {"Department"= "Finance"}
    # image_policy_config {

    #     #Optional
    #     is_policy_enabled = var.cluster_image_policy_config_is_policy_enabled
    #     key_details {

    #         #Optional
    #         kms_key_id = oci_kms_key.test_key.id
    #     }
    # }
    # kms_key_id = oci_kms_key.test_key.id
    # options {

    #     #Optional
    #     add_ons {

    #         #Optional
    #         is_kubernetes_dashboard_enabled = var.cluster_options_add_ons_is_kubernetes_dashboard_enabled
    #         is_tiller_enabled = var.cluster_options_add_ons_is_tiller_enabled
    #     }
    #     admission_controller_options {

    #         #Optional
    #         is_pod_security_policy_enabled = var.cluster_options_admission_controller_options_is_pod_security_policy_enabled
    #     }
    #     kubernetes_network_config {

    #         #Optional
    #         pods_cidr = var.cluster_options_kubernetes_network_config_pods_cidr
    #         services_cidr = var.cluster_options_kubernetes_network_config_services_cidr
    #     }
    #     persistent_volume_config {

    #         #Optional
    #         defined_tags = {"Operations.CostCenter"= "42"}
    #         freeform_tags = {"Department"= "Finance"}
    #     }
    #     service_lb_config {

    #         #Optional
    #         defined_tags = {"Operations.CostCenter"= "42"}
    #         freeform_tags = {"Department"= "Finance"}
    #     }
    #     service_lb_subnet_ids = var.cluster_options_service_lb_subnet_ids
    # }
    # type = var.cluster_type
}