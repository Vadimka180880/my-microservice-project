variable "region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "namespace" {
  type    = string
  default = "monitoring"
}

variable "chart_version" {
  type    = string
  default = "56.6.2"
}

variable "grafana_admin_password" {
  type      = string
  sensitive = true
}
