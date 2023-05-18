resource "google_container_cluster" "lol_cluster" {
  name               = var.cluster_name
  initial_node_count = var.node_count

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.private_subnet.self_link
  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "10.0.1.0/28"
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "10.0.0.0/16"
    }
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.4.0.0/14"
    services_ipv4_cidr_block = "192.168.0.0/20"
  }

}

output "kubeconfig_path" {
  value = google_container_cluster.lol_cluster.master_auth.0.cluster_ca_certificate
}

output "cluster_endpoint" {
  value = google_container_cluster.lol_cluster.endpoint
}
