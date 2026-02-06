output "namespace" {
  value = var.namespace
}

output "admin_user" {
  value = var.admin_user
}

output "admin_password" {
  value     = var.admin_password
  sensitive = true
}
