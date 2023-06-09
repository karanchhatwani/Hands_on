variable "project_id" {
  default  = "nimble-unison-386200"
}

variable "region" {
  description = "The region where the cluster will be created."
  default     = "us-central1"
}

variable "zone" {
  description = "The zone where the cluster will be created."
  default     = "us-central1-a"
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster."
  default     = "my-cluster"
}