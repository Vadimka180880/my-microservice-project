variable "name_prefix" {
  type        = string
  description = "Prefix for naming DB resources"
  default     = "app"
}

variable "use_aurora" {
  type        = bool
  description = "Create Aurora cluster when true, otherwise create single RDS instance"
  default     = false
}

variable "engine" {
  type        = string
  description = "Database engine (postgres, mysql, aurora-postgresql, aurora-mysql)"
  default     = "postgres"
}

variable "engine_version" {
  type        = string
  description = "Engine version"
  default     = "15.5"
}

variable "instance_class" {
  type        = string
  description = "Instance class for RDS/Aurora instances"
  default     = "db.t3.micro"
}

variable "multi_az" {
  type        = bool
  description = "Enable Multi-AZ for RDS instance"
  default     = false
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage (GB) for RDS instance"
  default     = 20
}

variable "storage_type" {
  type        = string
  description = "Storage type for RDS instance"
  default     = "gp3"
}

variable "db_name" {
  type        = string
  description = "Initial database name"
  default     = "appdb"
}

variable "username" {
  type        = string
  description = "Master username"
  default     = "appuser"
}

variable "password" {
  type        = string
  description = "Master password"
  sensitive   = true
}

variable "port" {
  type        = number
  description = "Database port (0 = default by engine)"
  default     = 0
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for DB subnet group"
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks allowed to access the DB"
  default     = ["0.0.0.0/0"]
}

variable "parameter_group_family" {
  type        = string
  description = "Parameter group family for RDS instance"
  default     = "postgres15"
}

variable "aurora_parameter_group_family" {
  type        = string
  description = "Parameter group family for Aurora cluster"
  default     = "aurora-postgresql15"
}

variable "backup_retention_period" {
  type        = number
  description = "Backup retention in days"
  default     = 7
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot on delete"
  default     = true
}

variable "deletion_protection" {
  type        = bool
  description = "Enable deletion protection"
  default     = false
}

variable "publicly_accessible" {
  type        = bool
  description = "Make DB publicly accessible"
  default     = false
}

variable "aurora_instance_count" {
  type        = number
  description = "Number of Aurora instances"
  default     = 1
}

variable "apply_immediately" {
  type        = bool
  description = "Apply changes immediately"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
  default     = {}
}
