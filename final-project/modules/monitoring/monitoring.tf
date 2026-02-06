resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "monitoring" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = var.namespace
  version    = var.chart_version

  values = [file("${path.module}/values.yaml")]

  set_sensitive = [
    {
      name  = "grafana.adminPassword"
      value = var.grafana_admin_password
    }
  ]

  depends_on = [kubernetes_namespace.this]
}

data "kubernetes_service" "grafana" {
  metadata {
    name      = "kube-prometheus-stack-grafana"
    namespace = var.namespace
  }

  depends_on = [helm_release.monitoring]
}

output "grafana_service_name" {
  value = data.kubernetes_service.grafana.metadata[0].name
}
