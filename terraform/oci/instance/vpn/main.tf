resource "oci_core_instance" "example_instance" {
  availability_domain = var.availability_domain
  display_name = var.instance_display_name
  compartment_id      = var.compartment_id
  shape               = var.shape

  create_vnic_details {
    subnet_id = data.terraform_remote_state.vcn.outputs.node_subnet_id
  }

  source_details {
    source_type = "image"

    source_id = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaaqqu7h5rkavka5z2343l64qdfp445c6wyfbmvrphmoy4377xa4aa"
  }

  metadata = {
    ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDpvo1cRcGreh+KiS5TjAsVQ3SZLtY1hTM6h+f9QcbCw5Sqe9HBFqK1Uo7z5M5BXTr11prmJcOyks1yFWItUnlEkoA2hKKtZQRsmZWzYHBPHOwmMKUt+V7aSdLMP54PsBIhO0ftP8ffTHqPyTsBH7QKTn69CCWTm4Leb+USy5JoOyjbBFLU+EDBFYJHmGJZIOftiz4mzflTVTfpcF4LEdYbR27NVmKSZ9CVzGQtMwwi3JgHkCxXT56DK11KiM5zNAHr9zgslxlCwtNjBPVMvTM0BeAufxCWYChKxvA89wHIep20XnavO+jIBHJ1LnzriNyXz8alTP9QQZDUUbmQyq24OS0D2v7nrdaCURS8Yaowp5dpah25bfrlXzBSvz+irDLShnSLhEyRvd4GRE+fqyKbA6Yj/UZLRYW6gdeAOu3XNexeQnZyLplb+Rfvah7ZfRXb123ZtWxtzyuHaOqkq/R4NkBiRtYsYkjJmBzSnk4IOzZ4V6ejaJiO+zbMJPrRxUk= wpalmeida@LAPTOP-BRP52PDQ"
  }
}