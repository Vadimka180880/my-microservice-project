resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "argo_cd" {
  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = var.namespace
  version    = var.chart_version

  values = [file("${path.module}/values.yaml")]

  depends_on = [kubernetes_namespace.this]
}

resource "helm_release" "argo_apps" {
  name      = "argo-apps"
  chart     = "${path.module}/charts/argo-apps"
  namespace = var.namespace

  values = [file("${path.module}/charts/argo-apps/values.yaml")]

  set = [
    {
      name  = "repositories[0].url"
      value = var.repo_url
    },
    {
      name  = "applications[0].repoURL"
      value = var.repo_url
    },
    {
      name  = "applications[0].path"
      value = var.app_path
    },
    {
      name  = "applications[0].targetRevision"
      value = var.app_revision
    },
    {
      name  = "applications[0].destination.namespace"
      value = var.destination_ns
    }
  ]

  depends_on = [helm_release.argo_cd]
}
