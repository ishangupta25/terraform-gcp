# // VPC firewall configuration

//Allow ping from all subnets to everywhere if network reachable.
resource "google_compute_firewall" "allow-ping" {
  name             = "allow-ping"
  network          = "${google_compute_network.terraform.name}"
  provider         = "google-beta"
  enable_logging   = "true"
  allow {
    protocol = "icmp"
  }
  source_ranges = ["${var.private_cidr}", "${var.public_cidr}" ]
}


//Allow all tcp ports to communicate within a public subnet
resource "google_compute_firewall" "allow-within-public" {
  name             = "allow-within-public"
  network          = "${google_compute_network.terraform.name}"
  provider         = "google-beta"
  enable_logging   = "true"
  allow {
    protocol = "tcp"
  }
  source_ranges = ["${var.public_cidr}"]
  target_tags = ["public"]
}

//Allow all tcp ports to communicate within a private subnet
resource "google_compute_firewall" "allow-within-private" {
  name             = "allow-within-private"
  network          = "${google_compute_network.terraform.name}"
  provider         = "google-beta"
  enable_logging   = "true"
  allow {
    protocol = "tcp"
  }
  source_ranges = ["${var.private_cidr}"]
  target_tags = ["private"]
}

//Allow ssh and https for public subnet from 0.0.0.0/0
resource "google_compute_firewall" "allow-public" {
  name             = "allow-public"
  network          = "${google_compute_network.terraform.name}"
  provider         = "google-beta"
  enable_logging   = "true"
  allow {
    protocol = "tcp"
    ports    = ["22", "443"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["public"]
}

//Allow ssh and https from public subnet to private subnet
resource "google_compute_firewall" "allow-private-from-public" {
  name             = "allow-private-from-public"
  network          = "${google_compute_network.terraform.name}"
  provider         = "google-beta"
  enable_logging   = "true"
  allow {
    protocol = "tcp"
    ports    = ["22", "443"]
  }
  source_ranges = ["${var.public_cidr}"]
  target_tags = ["private"]
}
