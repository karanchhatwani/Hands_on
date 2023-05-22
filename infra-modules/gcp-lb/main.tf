
resource "google_compute_target_pool" "load_balancer_pool" {
  name   = "lol-pool1"
  region = "us-central1"

  instances = [
    "us-central1-a/web"
  ]
  health_checks = [
    "us-central1-a/web-health-check1"
  ]
  depends_on = [ google_compute_http_health_check.web_health_check ]
}
resource "google_compute_http_health_check" "web_health_check" {
  name                = "web-health-check1"
  port                = 8080
  request_path        = "/"
  check_interval_sec  = 10
  timeout_sec         = 5
  unhealthy_threshold = 3
  healthy_threshold   = 2
}

resource "google_compute_forwarding_rule" "web_forwarding_rule" {
  name                  = "web-forwarding-rule1"
  region                = "us-central1"
  target                = google_compute_target_pool.load_balancer_pool.self_link
  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"
  port_range            = "8080"
}


