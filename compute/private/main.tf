provider "google" {
  project = ""
  region  = "us-west1"
}

// Following can be used if need to put state file remotely in GCS bucket

//terraform {
//  backend "gcs" {
//    bucket  = ""
//    prefix  = ""
//    project = ""
//  }
//}

### Set variables here ####
locals {
    instance_name    = "private01"
    num_instances    = "1"
    machine_type     = "n1-standard-2"
    zone             = "us-west1-a"
    os_image         = "ubuntu-os-cloud/ubuntu-1604-lts"
    root_volume_size = "20"
    root_volume_type = "pd-standard"
    subnet_name      = "private"
    # Leave blank to set SA as default
    tags             = ["private"]
}
module "private" {
    source           = "../../modules/private_instance"
    zone             = "${local.zone}"
    num_instances    = "${local.num_instances}"
    instance_name    = "${local.instance_name}"
    machine_type     = "${local.machine_type}"
    os_image         = "${local.os_image}"
    root_volume_size = "${local.root_volume_size}"
    root_volume_type = "${local.root_volume_type}"
    subnet_name      = "${local.subnet_name}"
    tags             = "${local.tags}"
}