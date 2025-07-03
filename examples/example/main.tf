provider "google" {
  project        = "project-name"
  region         = "us-east1"
}

module "gridgain" {
  source = "../../"

  project_id     = "project-id"
  image_id       = "vmi-gridgain-db-9-1-3-byol-v00-09-pr-114-0-0-1-4"
  nodes_count    = 2
  public_access_enable = true
  ssh_pub_key    = "ssh-rsa public-key"

  gridgain_config         = file("files/gridgain-config.conf")
  gridgain_logging_config = file("files/gridgain-logging.conf")
  gridgain_license        = file("files/gridgain-license.conf")
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
