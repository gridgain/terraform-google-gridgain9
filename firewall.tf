locals {
  iap_cidrs      = ["35.235.240.0/20"]
  exposed_ports  = ["22", "3344", "10300", "10400", "10800"]
}

resource "google_compute_firewall" "iap_ssh" {
  count     = var.enable_oslogin ? 1 : 0
  project   = var.project_id
  name      = "${var.name_prefix}-allow-iap-ssh"
  network   = local.vpc_id
  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = local.iap_cidrs
}

resource "google_compute_firewall" "icmp" {
  name      = "${var.name_prefix}-allow-icmp"
  network   = local.vpc_id
  direction = "INGRESS"
  allow {
    protocol = "icmp"
  }
  source_ranges = [var.subnet_cidr]
}

resource "google_compute_firewall" "public_icmp" {
  count   = var.public_access_enable ? 1 : 0
  name      = "${var.name_prefix}-allow-public-icmp"
  network   = local.vpc_id
  direction = "INGRESS"
  allow {
    protocol = "icmp"
  }
  source_ranges = var.public_allowlist
}

resource "google_compute_firewall" "ingress" {
  name    = "${var.name_prefix}-ingress"
  network = local.vpc_id

  allow {
    protocol = "tcp"
    ports    = local.exposed_ports
  }

  source_ranges = [var.subnet_cidr]
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