output "db_endpoint" {
  description = "RDS instance endpoint"
  value       = module.rds.db_endpoint
}

output "aurora_writer_endpoint" {
  description = "Aurora writer endpoint"
  value       = module.rds.aurora_writer_endpoint
}

output "aurora_reader_endpoint" {
  description = "Aurora reader endpoint"
  value       = module.rds.aurora_reader_endpoint
}

output "db_port" {
  description = "Database port"
  value       = module.rds.db_port
}

output "security_group_id" {
  description = "Security group ID"
  value       = module.rds.security_group_id
}

output "subnet_group_name" {
  description = "DB subnet group name"
  value       = module.rds.subnet_group_name
}
