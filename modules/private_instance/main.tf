resource "google_compute_address" "static" {
  name = "ipv4-address-${var.instance_name}"
  address_type = "INTERNAL"
  subnetwork = "${var.subnet_name}"
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
  
  metadata {
    ssh-keys               = "ishan:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCuSSnfSjgxJXjZ8AZu/9me96ZG2rYcpJ3sPACi8ra0BZjWUfXAmAXdzIcYbu54UqoxiesP1sObng2w75zOJXfEKViQ6iqT2zLkOo5TMN9X4+j1wwKjX0fRC4ewnRTHCHsUvrtXhYBl5UGpA72EbUxq0K6NPVNIBBkDaYrwaAXgAKvLyMEK2i0cbxbKAybbEI1haWzUFv913+f+XGxaKdxyGJagrRhJNUdhULfpJTitmhCJco6zU3vRv4UisPURK6DNk5jbeDREGO9GkpvcOEqib1OwQ1vneNKaSMf3c/xs3j8fYKp7AQBEKH77VuFAvcqQzBvIq9y2klkhFCH5 root@232eb2c1ec17"
  }

  network_interface {
    subnetwork    = "${var.subnet_name}"
    network_ip    = "${google_compute_address.static.address}"
  }

}
