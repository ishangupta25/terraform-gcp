//create a static IP for nat-gateway

resource "google_compute_address" "nat-gateway-ip" {
  name    = "nat-gateway-ip"

}

//create router
resource "google_compute_router" "nat-router" {
  name    = "nat-router"
  network = "${var.vpc_name}"
  bgp {
    asn = 64514
  }
  depends_on = ["google_compute_network.terraform"]
}

//create cloud-NAT or nat-gateway, assign static IP and attach it to required subnets.
resource "google_compute_router_nat" "nat-gateway" {
  name                               = "nat-gateway"
  router                             = "${google_compute_router.nat-router.name}"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = ["${google_compute_address.nat-gateway-ip.self_link}"]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name = "${google_compute_subnetwork.subnet-private.self_link}"
    source_ip_ranges_to_nat = ["PRIMARY_IP_RANGE"]
  }
}
