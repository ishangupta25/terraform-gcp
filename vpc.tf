// Configure the Google Cloud provider
provider "google" {
 project     = ""
 region      = "us-west1"

}

provider "google-beta" {
 project     = ""
 region      = "us-west1"
}
//Set up remote state file for terraform state in GCS.
//terraform {
//  backend "gcs" {
//    bucket  = ""
//    prefix  = ""
//    project = ""
//  }
//}
//Define variables

locals {
  vpc_name                  =    "prod-vpc"
  env                       =    "primary"
  public_cidr               =    "172.20.10.0/24"
  private_cidr              =    "172.20.20.0/24"
}

//Create a VPC through a module
module "vpc"{
  source                    =    "modules/vpc"
  vpc_name                  =    "${local.vpc_name}"
  public_cidr               =    "${local.public_cidr}"
  private_cidr              =    "${local.private_cidr}"
}
