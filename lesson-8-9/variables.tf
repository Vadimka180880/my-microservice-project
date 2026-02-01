variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "tf_state_bucket_name" { type = string }
variable "tf_lock_table_name"   { type = string }

variable "vpc_name" { type = string }
variable "vpc_cidr" { type = string }

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}

variable "ecr_repository_name" {
  type = string
}

variable "eks_cluster_name" {
  type = string
}

variable "eks_cluster_version" {
  type    = string
  default = "1.29"
}

variable "eks_node_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "eks_node_desired_size" {
  type    = number
  default = 2
}

variable "eks_node_min_size" {
  type    = number
  default = 2
}

variable "eks_node_max_size" {
  type    = number
  default = 6
}

variable "enable_jenkins" {
  type    = bool
  default = false
}

variable "enable_argo_cd" {
  type    = bool
  default = false
}

variable "enable_ebs_csi_addon" {
  type    = bool
  default = true
}

variable "ebs_csi_role_arn" {
  type    = string
  default = ""
}

variable "jenkins_namespace" {
  type    = string
  default = "jenkins"
}

variable "jenkins_chart_version" {
  type    = string
  default = "5.7.7"
}

variable "jenkins_admin_user" {
  type = string
}

variable "jenkins_admin_password" {
  type      = string
  sensitive = true
}

variable "argo_cd_namespace" {
  type    = string
  default = "argocd"
}

variable "argo_cd_chart_version" {
  type    = string
  default = "7.7.5"
}

variable "argo_cd_repo_url" {
  type = string
}

variable "argo_cd_app_path" {
  type = string
}

variable "argo_cd_app_revision" {
  type    = string
  default = "main"
}

variable "argo_cd_destination_ns" {
  type    = string
  default = "default"
}
