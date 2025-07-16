locals {
  enable_project_oslogin = var.enable_project_oslogin ? true : false
  principals = length(var.oslogin_access_principals) > 0 ? var.oslogin_access_principals : [
    "user:${data.google_client_openid_userinfo.this.email}"
  ]
}

data "google_client_openid_userinfo" "this" {}

resource "google_service_account" "sa" {
  account_id   = "${var.name_prefix}-sa"
  display_name = "${var.name_prefix} VM service account"
}

resource "google_project_iam_member" "sa_logging" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_member" "sa_metrics_writer" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_compute_project_metadata" "enable_oslogin" {
  count         = local.enable_project_oslogin ? 1: 0
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_project_iam_member" "iap_tunnel" {
  for_each = toset(local.principals)
  project  = var.project_id
  role     = "roles/iap.tunnelResourceAccessor"
  member   = each.value
}

resource "google_project_iam_member" "os_login" {
  for_each = toset(local.principals)
  project  = var.project_id
  role     = "roles/compute.osLogin"
  member   = each.value
}

resource "google_project_iam_member" "os_admin_login" {
  for_each = toset(local.principals)
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
}
