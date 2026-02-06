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

  set = [
    {
      name  = "controller.admin.username"
      value = var.admin_user
    }
  ]

  set_sensitive = [
    {
      name  = "controller.admin.password"
      value = var.admin_password
    }
  ]

  depends_on = [kubernetes_namespace.this]
}
  