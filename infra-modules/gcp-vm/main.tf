resource "google_compute_instance" "web" {
  name = "web"
  machine_type = "n1-standard-1"
  zone = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "image-1"
    }
  }
  network_interface {
    subnetwork = var.private_subnet
    network_ip = var.private_vpc
    }
}