resource "google_service_account" "sa" {
  account_id   = "${var.name_prefix}-sa"
  display_name = "${var.name_prefix} VM service account"
}

resource "google_project_iam_member" "sa_logging" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_kms_key_ring_iam_member" "sa_keyring_admin" {
  count         = local.create_kms_keys ? 1: 0
  key_ring_id   = local.kms_key_ring_id
  role          = "roles/cloudkms.admin"
  member        = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_kms_crypto_key_iam_member" "sa_crypto_key_admin" {
  count         = local.create_kms_keys ? 1: 0
  crypto_key_id = local.kms_crypto_key_id
  role          = "roles/cloudkms.admin"
  member        = "serviceAccount:${google_service_account.sa.email}"
}      
