resource "google_compute_instance" "web" {
  name = "web"
  machine_type = "n1-standard-1"
  zone = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2004-focal-v20230427"
    }
  }
  network_interface {
    subnetwork = module.vpc.private_subnet.self_link
    network_ip = module.vpc.address.self_link
    }
    metadata_startup_script = file("startup.sh")
}