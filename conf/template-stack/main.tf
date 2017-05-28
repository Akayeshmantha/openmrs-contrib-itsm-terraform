# state file stored in S3
terraform {
  backend "s3" {
    bucket = "openmrs-terraform-state-files"
    key    = "STACK-NAME.tfstate"
  }
}

# any resources from the base stack
data "terraform_remote_state" "base" {
    backend = "s3"
    config {
        bucket = "openmrs-terraform-state-files"
        key    = "basic-network-setup.tfstate"
    }
}

module "single-machine" {
  source            = "../modules/single-machine"
  flavor            = "${var.flavor}"
  image             = "${var.image}"
  hostname          = "${var.hostname}"
  project_name      = "${var.project_name}"
  ssh_username      = "${var.ssh_username}"
  ssh_key_file      = "${var.ssh_key_file}"
  domain_dns        = "${var.domain_dns}"
  ansible_repo      = "${var.ansible_repo}"
  ansible_inventory = "${var.ansible_inventory}"
  has_backup        = false
  use_ansible       = false
}
