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
    subnetwork = google_compute_subnetwork.private_subnet.self_link
    network_ip = google_compute_address.ip_address.address
    }
    metadata_startup_script = file("startup.sh")
}

resource "google_compute_target_pool" "load_balancer_pool" {
  name   = "lol-pool"
  region = "us-central1"

  instances = [
    "us-central1-a/web"
  ]
  health_checks = [
    "us-central1-a/web-health-check"
  ]
}
resource "google_compute_http_health_check" "web_health_check" {
  name                = "web-health-check"
  port                = 8080
  request_path        = "/"
  check_interval_sec  = 10
  timeout_sec         = 5
  unhealthy_threshold = 3
  healthy_threshold   = 2
}

resource "google_compute_forwarding_rule" "web_forwarding_rule" {
  name                  = "web-forwarding-rule"
  region                = "us-central1"
  target                = google_compute_target_pool.load_balancer_pool.self_link
  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"
  port_range            = "8080"
}


