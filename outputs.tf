################################################################################
# Networking
################################################################################

output "vpc_id" {
  description = "ID of the created/provided subnet"
  value       = local.vpc_id
}

output "subnet_id" {
  description = "ID of the created subet"
  value       = local.subnet
}

output "cluster_dns" {
  description = "Gridgain Cluster FQDN"
  value       = try(local.cluster_dns, "")
}

output "cluster_url" {
  description = "Gridgain Cluster FQDN"
  value       = try(local.cluster_url, "")
}

################################################################################
# Encryption
################################################################################
output "kms_keyring_id" {
  description = "KMS keyring id used for encryption"
  value       = local.kms_key_ring_id
}

output "kms_key_id" {
  description = "KMS key id used for encryption"
  value       = local.kms_crypto_key_id
}

################################################################################
# Instances
################################################################################
output "instance_ids" {
  description = "List of compute instance IDs"
  value = try(
    google_compute_instance.this.*.id,
    [],
  )
}

output "instance_links" {
  description = "List of compute instance self links"
  value = try(
    google_compute_instance.this.*.self_link,
    [],
  )
}

output "instance_status" {
  description = "List of instance status"
  value = try(
    google_compute_instance.this.*.instance_status,
    [],
  )
}

output "public_ips" {
  description = "List of public IP addresses assigned to the instances"
  value = try(local.public_ips, [])
}

output "private_ips" {
  description = "List of private IP addresses assigned to the instances"
  value = try(local.private_ips, [])
}

output "image_id" {
  description = "Image ID that was used to create the instances"
  value = var.image_id
}

################################################################################
# IAM / Service accounts
################################################################################

output "service_account" {
  description = "Service Account ID"
  value       = try(google_service_account.sa.account_id, "")
}

output "oslogin_connect_commands" {
  description = "The gcloud CLI command to connect to the compute instance using OSLogin"
  value = [
    for instance in google_compute_instance.this : "gcloud compute ssh --zone ${instance.zone} ${instance.name} --project ${var.project_id}"
  ]
}
