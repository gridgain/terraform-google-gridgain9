locals {
  principals = var.oslogin_access_principals
}

resource "google_service_account" "sa" {
  project      = var.project_id
  account_id   = "${var.name_prefix}-sa"
  display_name = "${var.name_prefix} VM service account"
}

resource "google_project_iam_member" "sa_logging" {
  count   = var.enable_logging ? 1: 0
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.sa.email}"
  
  depends_on = [google_service_account.sa]
}

resource "google_project_iam_member" "sa_metrics_writer" {
  count   = var.enable_monitoring ? 1: 0
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.sa.email}"
  
  depends_on = [google_service_account.sa]
}

resource "google_compute_project_metadata" "enable_oslogin" {
  count         = var.enable_project_oslogin ? 1: 0
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_project_iam_member" "iap_tunnel" {
  for_each = length(local.principals) > 0 ? toset(local.principals) : toset([])
  project  = var.project_id
  role     = "roles/iap.tunnelResourceAccessor"
  member   = each.value
}

resource "google_project_iam_member" "os_login" {
  for_each = length(local.principals) > 0 ? toset(local.principals) : toset([])
  project  = var.project_id
  role     = "roles/compute.osLogin"
  member   = each.value
}

resource "google_project_iam_member" "os_admin_login" {
  for_each = length(local.principals) > 0 ? toset(local.principals) : toset([])
  project  = var.project_id
  role     = "roles/compute.osAdminLogin"
  member   = each.value
}

resource "google_kms_crypto_key_iam_binding" "sa_encrypter" {
  count         = local.create_kms_keys ? 1: 0
  crypto_key_id = local.kms_crypto_key_id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members       = [
    "serviceAccount:${google_service_account.sa.email}"
  ]
  
  depends_on = [google_service_account.sa]
}
