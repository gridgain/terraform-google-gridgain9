locals {
  iap_cidrs      = ["35.235.240.0/20"]
  exposed_ports  = ["22", "3344", "10300", "10400", "10800"]
}

resource "google_compute_firewall" "iap_ssh" {
  count     = var.enable_oslogin ? 1 : 0
  name      = "allow-iap-ssh"
  network   = local.vpc_id
  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = local.iap_cidrs
}

resource "google_compute_firewall" "icmp" {
  count   = var.public_access_enable ? 1 : 0
  name      = "allow-icmp"
  network   = local.vpc_id
  direction = "INGRESS"
  allow {
    protocol = "icmp"
  }
  source_ranges = var.public_allowlist
}

resource "google_compute_firewall" "public_ingress" {
  count   = var.public_access_enable ? 1 : 0
  name    = "${var.name_prefix}-public-ingress"
  network = local.vpc_id

  allow {
    protocol = "tcp"
    ports    = local.exposed_ports
  }

  source_ranges = var.public_allowlist
}