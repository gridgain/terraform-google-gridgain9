locals {
  create_kms_keyring = var.enable_disk_encryption && var.kms_key_ring_id == "" ? true : false
  create_kms_keys    = var.enable_disk_encryption && var.kms_crypto_key_id == "" ? true : false

  kms_key_ring_id   = local.create_kms_keyring ? google_kms_key_ring.this[0].id : var.kms_key_ring_id
  kms_crypto_key_id = local.create_kms_keys ? google_kms_crypto_key.this[0].id : var.kms_crypto_key_id
}

resource "google_kms_key_ring" "this" {
  count    = local.create_kms_keyring ? 1: 0
  name     = "${var.name_prefix}-${random_id.kms[0].hex}-key-ring"
  location = var.kms_location
}

resource "google_kms_crypto_key" "this" {
  count           = local.create_kms_keys ? 1: 0
  name            = "${var.name_prefix}-${random_id.kms[0].hex}-disk-key"
  key_ring        = local.kms_key_ring_id
  rotation_period = "120000s"
}

resource "random_id" "kms" {
  count           = local.create_kms_keys ? 1: 0
  byte_length = 4
}