// Create VPC
resource "google_compute_network" "terraform" {
  name                    = "${var.vpc_name}"
  auto_create_subnetworks = "false"
}

// Create Subnets under the VPC.
resource "google_compute_subnetwork" "subnet-private" {
  name          = "private"
  ip_cidr_range = "${var.private_cidr}"
  network       = "${var.vpc_name}"
  depends_on = ["google_compute_network.terraform"]
}

resource "google_compute_subnetwork" "subnet-public" {
  name          = "public"
  ip_cidr_range = "${var.public_cidr}"
  network       = "${var.vpc_name}"
  depends_on = ["google_compute_network.terraform"]
}

