terraform {
  required_version = ">= 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "rds" {
  source = "./modules/rds"

  name_prefix  = var.name_prefix
  use_aurora   = var.use_aurora
  engine       = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  multi_az     = var.multi_az
  allocated_storage = var.allocated_storage
  storage_type = var.storage_type

  db_name  = var.db_name
  username = var.username
  password = var.password
  port     = var.port

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  allowed_cidr_blocks = var.allowed_cidr_blocks

  parameter_group_family       = var.parameter_group_family
  aurora_parameter_group_family = var.aurora_parameter_group_family

  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
  deletion_protection     = var.deletion_protection
  publicly_accessible     = var.publicly_accessible
  aurora_instance_count   = var.aurora_instance_count
  apply_immediately       = var.apply_immediately

  tags = var.tags
}
