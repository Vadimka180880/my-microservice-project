data "kubernetes_service" "argocd_server" {
  metadata {
    name      = "argocd-server"
    namespace = var.namespace
  }

  depends_on = [helm_release.argo_cd]
}

data "kubernetes_secret" "argocd_admin" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = var.namespace
  }

  depends_on = [helm_release.argo_cd]
}

output "namespace" {
  value = var.namespace
}

output "server_hostname" {
  value = try(data.kubernetes_service.argocd_server.status[0].load_balancer[0].ingress[0].hostname, "")
}

output "initial_admin_password" {
  value     = try(data.kubernetes_secret.argocd_admin.data.password, "")
  sensitive = true
}
