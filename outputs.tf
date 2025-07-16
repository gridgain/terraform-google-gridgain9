################################################################################
# Networking
################################################################################

output "vpc_id" {
  description = "ID of the created/provided subnet"
  value       = try(google_compute_network.vpc[0].id, null)
}

output "subnet_id" {
  description = "ID of the created subet"
  value       = try(google_compute_subnetwork.subnet[0].id, null)
}

output "cluster_dns" {
  description = "Gridgain Cluster FQDN"
  value       = try(google_dns_record_set.cluster_record[0].name, null)
}

################################################################################
# Encryption
################################################################################
output "kms_keyring_id" {
  description = "KMS keyring id used for encryption"
  value       = try(google_kms_key_ring.this[0].id, null)
}

output "kms_key_id" {
  description = "KMS key id used for encryption"
  value       = try(google_kms_crypto_key.this[0].id, null)
}

################################################################################
# Instances
################################################################################
output "instance_ids" {
  description = "List of compute instance IDs"
  value = try(
    google_compute_instance.this.*.instance_id,
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
    google_compute_instance.this.*.current_status,
    [],
  )
}

output "public_ips" {
  description = "List of public IP addresses assigned to the instances"
  value = try(google_compute_instance.this.*.network_interface.0.access_config.0.nat_ip, [])
}

output "private_ips" {
  description = "List of private IP addresses assigned to the instances"
  value = try(google_compute_instance.this.*.network_interface.0.network_ip, [])
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
