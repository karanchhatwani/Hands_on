resource "google_container_cluster" "my_cluster" {
  name               = var.cluster_name
  initial_node_count = var.node_count

  node_config {
    machine_type = var.machine_type
  }
}