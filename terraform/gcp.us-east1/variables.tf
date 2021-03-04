variable "project_id" {
  type = string
  description = "project id"
}

variable "region" {
  type = string
  description = "region"
}

variable "zone" {
  type = string
  description = "zone"
}

variable "gke_num_nodes" {
  type = number
  default     = 1
  description = "number of gke nodes"
}

variable "cloud_sql_tier" {
  type = string
  default = "db-f1-micro"
  description = "machine tier for cloud sql db"
}