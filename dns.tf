locals {
  cluster_dns = var.gridgain_cluster_dns !="" ? var.gridgain_cluster_dns : google_dns_record_set.cluster_record[0].name
}

resource "google_dns_managed_zone" "cluster_zone" {
  count    = var.gridgain_cluster_dns == "" ? 1 : 0
  name     = "${var.name_prefix}-cluster-local"
  dns_name = "cluster.local."

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = local.vpc_id
    }
  }
}

resource "google_dns_record_set" "cluster_record" {
  count = var.gridgain_cluster_dns == "" ? 1 : 0
  name  = "gridgain.${google_dns_managed_zone.cluster_zone[0].dns_name}"
  type  = "A"
  ttl   = 300

  managed_zone = google_dns_managed_zone.cluster_zone[0].name

  rrdatas = google_compute_address.instance_ip[*].address
}