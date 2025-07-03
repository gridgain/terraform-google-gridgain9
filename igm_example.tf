# resource "google_compute_region_per_instance_config" "this" {
#   count = var.nodes_count

#   name = "${var.name_prefix}-${count.index}"
#   region_instance_group_manager = google_compute_region_instance_group_manager.this.name

#   preserved_state {
#     internal_ip {
#       interface_name = "nic0"
#       ip_address {
#         address = google_compute_address.instance_ip[count.index].id
#       }
#     }
#     metadata = {
#       node_id = count.index
#     }
#   }
# }

# resource "google_compute_region_instance_template" "this" {
#   machine_type = var.machine_type

#   lifecycle {
#     create_before_destroy = true
#   }
  
#   disk {
#     auto_delete            = true
#     boot                   = true
#     provisioned_iops       = var.root_disk_iops
#     provisioned_throughput = var.root_disk_throughput
#     source_image           = var.image_id

#     disk_type = var.root_disk_type
#     disk_size_gb = var.root_disk_size_gb
#     disk_encryption_key {
#       kms_key_self_link = google_kms_crypto_key.this.id
#     }
#   }

#   network_interface {
#     subnetwork = local.subnet
#     access_config {
#       # TODO: Make it depended on public_acccess var
#     }
#   }

#   service_account {
#     email  = google_service_account.sa.email
#     scopes = ["https://www.googleapis.com/auth/cloud-platform"]
#   }

#   metadata = {
#     "enable-oslogin"   = var.enable_oslogin
#     "ssh-keys"         = var.ssh_pub_key != "" ? "user:${var.ssh_pub_key}" : null
#     "user-data"        = templatefile("${path.module}/templates/user-data.yaml", {
#       gridgain_config_defined  = local.gridgain_config_defined
#       gridgain_license_defined = local.gridgain_license_defined
#       cluster_lb_dns   = google_compute_address.nlb_ip.address
#       gridgain_license = base64gzip(var.gridgain_license)
#       gridgain_config  = base64gzip(data.template_file.gridgain_config.rendered)
#       gridgain_logging = base64gzip(var.gridgain_logging_config)
#       # public_ips       = local.public_ips
#       # private_ips      = local.private_ips
#       nodes_count      = var.nodes_count

#       ssl_enable            = var.gridgain_ssl_enable
#       gridgain_ssl_cert     = base64gzip(var.gridgain_ssl_cert)
#       gridgain_ssl_key      = base64gzip(var.gridgain_ssl_key)
#       keystore_password     = var.keystore_password
#       metastore_group       = local.metastore_group
#       cluster_name          = var.name_prefix
#     })
#   }
# }

# resource "google_compute_region_instance_group_manager" "this" {
#   name               = "${var.name_prefix}-igm"
#   base_instance_name = var.name_prefix
#   wait_for_instances = true

#   version {
#     instance_template = google_compute_region_instance_template.this.id
#   }

#   update_policy {
#     type                         = "PROACTIVE"
#     instance_redistribution_type = "NONE"
#     minimal_action               = "REPLACE"
#     replacement_method           = "RECREATE"
#     max_surge_fixed              = 0
#     max_unavailable_fixed        = local.zone_count
#   }

#   # target_size = var.nodes_count
#   # wait_for_instances = true
#   distribution_policy_zones        = var.zones
#   distribution_policy_target_shape = "EVEN"
# }
