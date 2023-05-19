output "address" {
    description = ""
    value = google_compute_address.ip_address
  
}
output "private_subnet" {
    description = "sss"
    value = google_compute_subnetwork.private_subnet

  
}
output "vpc" {
    value = google_compute_network.vpc
  
}