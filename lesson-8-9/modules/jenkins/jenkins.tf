resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = var.namespace
  version    = var.chart_version

  values = [file("${path.module}/values.yaml")]

  set {
    name  = "controller.adminUser"
    value = var.admin_user
  }

  set {
    name  = "controller.adminPassword"
    value = var.admin_password
  }

  depends_on = [kubernetes_namespace.this]
}
