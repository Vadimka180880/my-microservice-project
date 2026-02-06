output "namespace" {
  value = var.namespace
}

output "grafana_admin_password" {
  value     = var.grafana_admin_password
  sensitive = true
}

output "grafana_service_name" {
  value = data.kubernetes_service.grafana.metadata[0].name
}
