provider "google" {
  project        = "project-name"
  region         = "us-east1"
}

module "gridgain" {
  source = "../../"

  project_id     = "project-id"
  nodes_count    = 2
  public_access_enable = true
  ssh_pub_key    = "ssh-rsa public-key"
  goog_cm_deployment_name = "test-deployment"

  gridgain_logging_config = file("files/gridgain-logging.conf")
  gridgain_license        = file("files/gridgain-license.conf")
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
