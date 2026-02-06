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

variable "rds_name_prefix" {
  type        = string
  description = "Prefix for DB resources"
  default     = "app"
}

variable "rds_use_aurora" {
  type        = bool
  description = "Create Aurora cluster when true"
  default     = false
}

variable "rds_engine" {
  type        = string
  description = "DB engine"
  default     = "postgres"
}

variable "rds_engine_version" {
  type        = string
  description = "DB engine version"
  default     = "15.5"
}

variable "rds_instance_class" {
  type        = string
  description = "DB instance class"
  default     = "db.t3.micro"
}

variable "rds_multi_az" {
  type        = bool
  description = "Multi-AZ for RDS instance"
  default     = false
}

variable "rds_allocated_storage" {
  type        = number
  description = "RDS storage (GB)"
  default     = 20
}

variable "rds_storage_type" {
  type        = string
  description = "RDS storage type"
  default     = "gp3"
}

variable "rds_db_name" {
  type        = string
  description = "Initial DB name"
  default     = "appdb"
}

variable "rds_username" {
  type        = string
  description = "Master username"
  default     = "appuser"
}

variable "rds_password" {
  type        = string
  description = "Master password"
  sensitive   = true
}

variable "rds_port" {
  type        = number
  description = "DB port (0 = default by engine)"
  default     = 0
}

variable "rds_allowed_cidr_blocks" {
  type        = list(string)
  description = "Allowed CIDR blocks"
  default     = ["10.0.0.0/16"]
}

variable "rds_parameter_group_family" {
  type        = string
  description = "RDS parameter group family"
  default     = "postgres15"
}

variable "rds_aurora_parameter_group_family" {
  type        = string
  description = "Aurora parameter group family"
  default     = "aurora-postgresql15"
}

variable "rds_backup_retention_period" {
  type        = number
  description = "Backup retention in days"
  default     = 7
}

variable "rds_skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot"
  default     = true
}

variable "rds_deletion_protection" {
  type        = bool
  description = "Deletion protection"
  default     = false
}

variable "rds_publicly_accessible" {
  type        = bool
  description = "Publicly accessible"
  default     = false
}

variable "rds_aurora_instance_count" {
  type        = number
  description = "Aurora instance count"
  default     = 1
}

variable "rds_apply_immediately" {
  type        = bool
  description = "Apply immediately"
  default     = true
}

variable "monitoring_namespace" {
  type        = string
  description = "Monitoring namespace"
  default     = "monitoring"
}

variable "monitoring_chart_version" {
  type        = string
  description = "kube-prometheus-stack chart version"
  default     = "56.6.2"
}

variable "grafana_admin_password" {
  type        = string
  description = "Grafana admin password"
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
  default     = {}
}
