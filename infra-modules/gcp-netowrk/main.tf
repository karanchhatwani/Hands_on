resource "google_compute_network" "vpc" {
  name = "try-vpcnew"
}

resource "google_compute_subnetwork" "private_subnet" {
  name = "sub-pri"
  region = var.region
  network = google_compute_network.vpc.id
  ip_cidr_range = "10.0.0.0/16"
}
resource "google_compute_global_address" "private_ip_block" {
  name         = "private-ip-block"
  purpose      = "VPC_PEERING"
  address_type = "INTERNAL"
  ip_version   = "IPV4"
  prefix_length = 20
  network       = google_compute_network.vpc.self_link
}
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_block.name]
}

#Firewall rule
resource "google_compute_firewall" "default" {
  name = "default"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports = ["80","22","8080","5432","3306"]
  }
    source_ranges = ["0.0.0.0/0"]
  }

resource "google_compute_address" "ip_address" {
  name         = "private-ip"
  address_type = "INTERNAL"
  address      = "10.0.42.42"
  subnetwork   = google_compute_subnetwork.private_subnet.id
}