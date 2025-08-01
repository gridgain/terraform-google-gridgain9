# IMPORTANT: Cluster won't be initialized until there is a DNS-record (gridgain_cluster_dns)
# DNS record should point to public IP addresses of created Virtual Machines

provider "google" {
  project        = "project-name"
  region         = "us-east1"
}

module "gridgain" {
  source = "../../"

  project_id     = "project-id"
  image_id       = "vmi-gridgain-db-9-1-4-byol-v00-09-0-0-1-7"
  nodes_count    = 2

  ssh_pub_key    = "ssh-rsa public-key"

  gridgain_config         = file("files/gridgain-config.conf")
  gridgain_logging_config = file("files/gridgain-logging.conf")
  gridgain_license        = file("files/gridgain-license.conf")
  gridgain_ssl_enable     = true
  gridgain_ssl_cert       = file("files/server.crt")
  gridgain_ssl_key        = file("files/server.key")
  keystore_password       = "password"

  # public_access_enable is required when using custom domain with gridgain_cluster_dns
  public_access_enable = true
  # certificate (gridgain_ssl_cert and gridgain_ssl_key) must be issued for the domain that is specified in gridgain_cluster_dns variable
  gridgain_cluster_dns = "gridgain-cluster.some.domain.com"
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
