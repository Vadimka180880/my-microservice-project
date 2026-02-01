output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "jenkins_namespace" {
  value = module.jenkins.namespace
}

output "jenkins_admin_user" {
  value = module.jenkins.admin_user
}

output "jenkins_admin_password" {
  value     = module.jenkins.admin_password
  sensitive = true
}

output "argocd_namespace" {
  value = module.argo_cd.namespace
}

output "argocd_server_hostname" {
  value = module.argo_cd.server_hostname
}

output "argocd_initial_admin_password" {
  value     = module.argo_cd.initial_admin_password
  sensitive = true
}
