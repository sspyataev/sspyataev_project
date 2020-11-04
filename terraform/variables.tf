variable "project_id" {
  description = "project id"
  default = "my-gke-cluster"
}

variable "region" {
  description = "region"
  default = "europe-north1"
}

variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
}
