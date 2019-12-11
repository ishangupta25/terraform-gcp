//Private static IPaddress
resource "google_compute_address" "private-static" {
  name = "ipv4-private-${var.instance_name}"
  address_type = "INTERNAL"
  subnetwork = "${var.subnet_name}"
}

//Public static IPaddress
resource "google_compute_address" "public-static" {
  name = "ipv4-public-${var.instance_name}"
}

data "template_file" "start-up" {
  template = "${file("${path.module}/files/start-up.tpl")}"
}

resource "google_compute_instance" "hosts" {
  count        = "${var.num_instances}"
  name         = "${var.instance_name}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"

  # Network tags for firewall rules
  tags = "${var.tags}"
 
  boot_disk {
    initialize_params {
      image = "${var.os_image}"
      type  = "${var.root_volume_type}"
      size  = "${var.root_volume_size}"
    }
  }

  lifecycle {
    ignore_changes = [ "boot_disk" ]
  }

  metadata_startup_script = "${data.template_file.start-up.rendered}"

  network_interface {
    subnetwork    = "${var.subnet_name}"
    network_ip    = "${google_compute_address.private-static.address}"
    access_config {
      nat_ip = "${google_compute_address.public-static.address}"
    }
  }

}
