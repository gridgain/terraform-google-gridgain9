
## GG9 Terraform Module for GCP

This module deploys the GG9 Java application to Google Cloud Platform.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.41.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.43.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_address.instance_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_firewall.iap_ssh](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.icmp](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.public_ingress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_network.vpc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_dns_managed_zone.cluster_zone](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone) | resource |
| [google_dns_record_set.cluster_record](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_kms_crypto_key.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_crypto_key_iam_member.sa_crypto_key_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_kms_key_ring.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_kms_key_ring_iam_member.sa_keyring_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring_iam_member) | resource |
| [google_project_iam_member.sa_logging](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_id.kms](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [template_file.gridgain_config](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_disk_encryption"></a> [enable\_disk\_encryption](#input\_enable\_disk\_encryption) | Enable disk encryption using KMS keys | `bool` | `false` | no |
| <a name="input_enable_oslogin"></a> [enable\_oslogin](#input\_enable\_oslogin) | Enable os login | `bool` | `true` | no |
| <a name="input_gridgain_cluster_dns"></a> [gridgain\_cluster\_dns](#input\_gridgain\_cluster\_dns) | GridGain Cluster DNS (FQDN) | `string` | `""` | no |
| <a name="input_gridgain_config"></a> [gridgain\_config](#input\_gridgain\_config) | GridGain config | `string` | `""` | no |
| <a name="input_gridgain_license"></a> [gridgain\_license](#input\_gridgain\_license) | GridGain license | `string` | `""` | no |
| <a name="input_gridgain_logging_config"></a> [gridgain\_logging\_config](#input\_gridgain\_logging\_config) | GridGain logging config | `string` | `""` | no |
| <a name="input_gridgain_ssl_cert"></a> [gridgain\_ssl\_cert](#input\_gridgain\_ssl\_cert) | GridGain SSL certificate. Important: The certificate must be issued for the domain zone that will be specified in gridgain\_cluster\_dns variable | `string` | `""` | no |
| <a name="input_gridgain_ssl_enable"></a> [gridgain\_ssl\_enable](#input\_gridgain\_ssl\_enable) | Whether SSL should be enabled | `bool` | `false` | no |
| <a name="input_gridgain_ssl_key"></a> [gridgain\_ssl\_key](#input\_gridgain\_ssl\_key) | GridGain SSL key | `string` | `""` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | ImageID to use for boot disk | `string` | n/a | yes |
| <a name="input_keystore_password"></a> [keystore\_password](#input\_keystore\_password) | SSL Keystore password | `string` | `""` | no |
| <a name="input_kms_crypto_key_id"></a> [kms\_crypto\_key\_id](#input\_kms\_crypto\_key\_id) | KMS crypto key in keyring | `string` | `""` | no |
| <a name="input_kms_key_ring_id"></a> [kms\_key\_ring\_id](#input\_kms\_key\_ring\_id) | KMS keyring id | `string` | `""` | no |
| <a name="input_kms_location"></a> [kms\_location](#input\_kms\_location) | KMS location | `string` | `""` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | GCP machine type | `string` | `"e2-medium"` | no |
| <a name="input_marketplace_labels"></a> [marketplace\_labels](#input\_marketplace\_labels) | Consumption‑tracking + common labels | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Name prefix to be used for all resources | `string` | `"gridgain9db"` | no |
| <a name="input_nodes_count"></a> [nodes\_count](#input\_nodes\_count) | Number of GG9 nodes. 1 = single node | `number` | `1` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | n/a | yes |
| <a name="input_public_access_enable"></a> [public\_access\_enable](#input\_public\_access\_enable) | Whether to assign external IPs to instances | `bool` | `false` | no |
| <a name="input_public_allowlist"></a> [public\_allowlist](#input\_public\_allowlist) | CIDR allow list for public subnet | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | GCP deployment region | `string` | `"us-east1"` | no |
| <a name="input_root_disk_iops"></a> [root\_disk\_iops](#input\_root\_disk\_iops) | Amount of provisioned IOPS for root disk | `number` | `null` | no |
| <a name="input_root_disk_size_gb"></a> [root\_disk\_size\_gb](#input\_root\_disk\_size\_gb) | Boot disk size in GB | `number` | `128` | no |
| <a name="input_root_disk_throughput"></a> [root\_disk\_throughput](#input\_root\_disk\_throughput) | Root disk throughput in MB/s | `number` | `null` | no |
| <a name="input_root_disk_type"></a> [root\_disk\_type](#input\_root\_disk\_type) | Boot disk size type | `string` | `"pd-balanced"` | no |
| <a name="input_ssh_pub_key"></a> [ssh\_pub\_key](#input\_ssh\_pub\_key) | SSH public key used to connect to instances (algorithm + public key). If empty, none will be provisioned | `string` | `""` | no |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | CIDR for private subnet | `string` | `"10.0.0.0/24"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID to be used for deployment. If empty, module should provision new subnets | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of an existing VPC network to attach | `string` | `""` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | List of zones to use (first element used for single‑node) | `list(string)` | <pre>[<br/>  "us-east1-b",<br/>  "us-east1-c"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_dns"></a> [cluster\_dns](#output\_cluster\_dns) | Gridgain Cluster FQDN |
| <a name="output_instance_ids"></a> [instance\_ids](#output\_instance\_ids) | List of compute instance IDs |
| <a name="output_instance_links"></a> [instance\_links](#output\_instance\_links) | List of compute instance self links |
| <a name="output_instance_status"></a> [instance\_status](#output\_instance\_status) | List of instance status |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | KMS key id used for encryption |
| <a name="output_kms_keyring_id"></a> [kms\_keyring\_id](#output\_kms\_keyring\_id) | KMS keyring id used for encryption |
| <a name="output_oslogin_connect_commands"></a> [oslogin\_connect\_commands](#output\_oslogin\_connect\_commands) | The gcloud CLI command to connect to the compute instance using OSLogin |
| <a name="output_private_ips"></a> [private\_ips](#output\_private\_ips) | List of private IP addresses assigned to the instances |
| <a name="output_public_ips"></a> [public\_ips](#output\_public\_ips) | List of public IP addresses assigned to the instances |
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | Service Account ID |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | ID of the created subet |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the created/provided subnet |