locals {
  gridgain_config_defined  = length(trimspace(var.gridgain_config)) > 0
  gridgain_logging_defined = length(trimspace(var.gridgain_logging_config)) > 0
  gridgain_license_defined = length(trimspace(var.gridgain_license)) > 0
  gridgain_default_config  = templatefile("${path.module}/templates/gridgain-config.conf.tpl", {
    cluster_dns       = local.cluster_dns
    ssl_enabled       = var.gridgain_ssl_enable
    keystore_password = var.keystore_password
  })
  gridgain_config          = local.gridgain_config_defined ? var.gridgain_config : local.gridgain_default_config
  private_ips              = join(",", [for ip in google_compute_address.instance_ip[*].address : format("\"%s:3344\"", ip)])
  public_ips               = var.public_access_enable ? flatten(google_compute_instance.this.*.network_interface.0.access_config.0.nat_ip) : []
  metastore_group          = join(",", [for i in range(var.nodes_count) : format("node%s", i)])
  cluster_url              = var.gridgain_ssl_enable ? "https://${local.cluster_dns}:10400" : "http://${local.cluster_dns}:10300"
}

resource "google_compute_address" "instance_ip" {
  count        = var.nodes_count
  project      = var.project_id
  region       = var.region
  name         = "${var.name_prefix}-${count.index}-internal-ip"
  address_type = "INTERNAL"
  subnetwork   = google_compute_subnetwork.subnet[0].id
}

resource "google_compute_instance" "this" {
  count   = var.nodes_count
  project = var.project_id
  name    = "${var.name_prefix}-${count.index}"
  machine_type = var.machine_type
  zone    = var.zones[count.index % local.zone_count]

  service_account {
    email  = google_service_account.sa.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  network_interface {
    network    = local.vpc_id
    subnetwork = local.subnet
    network_ip = google_compute_address.instance_ip[count.index].address

    dynamic "access_config" {
      for_each = var.public_access_enable ? [1] : []
      content {}
    }
  }

  boot_disk {
    kms_key_self_link = var.enable_disk_encryption ? local.kms_crypto_key_id : ""
    disk_encryption_service_account = var.enable_disk_encryption ? google_service_account.sa.email : ""

    initialize_params {
      image                  = var.source_image
      size                   = var.root_disk_size_gb
      type                   = var.root_disk_type
      provisioned_iops       = var.root_disk_iops
      provisioned_throughput = var.root_disk_throughput
    }
  }

  metadata = {
    "enable-oslogin"         = var.enable_oslogin ? "TRUE" : "FALSE"
    google-logging-enable    = var.enable_logging == true ? "1" : "0"
    google-monitoring-enable = var.enable_monitoring == true ? "1" : "0"
    "user-data"        = templatefile("${path.module}/templates/user-data.yaml", {
      ssh_pub_key      = var.ssh_pub_key
      gridgain_logging_defined = local.gridgain_logging_defined
      gridgain_license_defined = local.gridgain_license_defined
      cluster_dns      = local.cluster_dns
      cluster_url      = local.cluster_url
      gridgain_license = base64gzip(var.gridgain_license)
      gridgain_config  = base64gzip(local.gridgain_config)
      gridgain_logging = base64gzip(var.gridgain_logging_config)

      node_id          = count.index
      nodes_count      = var.nodes_count

      gridgain_ssl_enable   = var.gridgain_ssl_enable
      gridgain_ssl_cert     = base64gzip(var.gridgain_ssl_cert)
      gridgain_ssl_key      = base64gzip(var.gridgain_ssl_key)
      keystore_password     = var.keystore_password
      metastore_group       = local.metastore_group
      cluster_name          = var.name_prefix
    })
  }
}
