variable "cluster_name" {
  description = "The name of the Kubernetes cluster."
  default     = "my-cluster"
}
variable "node_count" {
  description = "The number of nodes in the cluster."
  default     = 1
}

variable "machine_type" {
  description = "The machine type of the nodes."
  default     = "n1-standard-1"
}

variable "vpc" {
  description = "using private VPC"
  default = ""
  
}