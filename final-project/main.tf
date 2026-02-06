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

module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = var.tf_state_bucket_name
  table_name  = var.tf_lock_table_name
}

module "vpc" {
  source = "./modules/vpc"

  vpc_name           = var.vpc_name
  vpc_cidr_block     = var.vpc_cidr

  public_subnets     = var.public_subnet_cidrs
  private_subnets    = var.private_subnet_cidrs

  availability_zones = var.azs
}

module "ecr" {
  source   = "./modules/ecr"
  ecr_name = var.ecr_repository_name
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_cluster_version
  subnet_ids      = module.vpc.private_subnet_ids

  node_instance_types = var.eks_node_instance_types
  node_desired_size   = var.eks_node_desired_size
  node_min_size       = var.eks_node_min_size
  node_max_size       = var.eks_node_max_size

  enable_ebs_csi_addon = var.enable_ebs_csi_addon
  ebs_csi_role_arn      = var.ebs_csi_role_arn
}

module "rds" {
  source = "./modules/rds"

  name_prefix      = var.rds_name_prefix
  use_aurora       = var.rds_use_aurora
  engine           = var.rds_engine
  engine_version   = var.rds_engine_version
  instance_class   = var.rds_instance_class
  multi_az         = var.rds_multi_az
  allocated_storage = var.rds_allocated_storage
  storage_type     = var.rds_storage_type

  db_name  = var.rds_db_name
  username = var.rds_username
  password = var.rds_password
  port     = var.rds_port

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
  allowed_cidr_blocks = var.rds_allowed_cidr_blocks

  parameter_group_family        = var.rds_parameter_group_family
  aurora_parameter_group_family = var.rds_aurora_parameter_group_family

  backup_retention_period = var.rds_backup_retention_period
  skip_final_snapshot     = var.rds_skip_final_snapshot
  deletion_protection     = var.rds_deletion_protection
  publicly_accessible     = var.rds_publicly_accessible
  aurora_instance_count   = var.rds_aurora_instance_count
  apply_immediately       = var.rds_apply_immediately

  tags = var.tags
}

module "jenkins" {
  source = "./modules/jenkins"

  region         = var.aws_region
  cluster_name   = module.eks.cluster_name
  namespace      = var.jenkins_namespace
  chart_version  = var.jenkins_chart_version
  admin_user     = var.jenkins_admin_user
  admin_password = var.jenkins_admin_password
}

module "argo_cd" {
  source = "./modules/argo_cd"

  region        = var.aws_region
  cluster_name  = module.eks.cluster_name
  namespace     = var.argo_cd_namespace
  chart_version = var.argo_cd_chart_version

  repo_url       = var.argo_cd_repo_url
  app_path       = var.argo_cd_app_path
  app_revision   = var.argo_cd_app_revision
  destination_ns = var.argo_cd_destination_ns
}

module "monitoring" {
  source = "./modules/monitoring"

  region                   = var.aws_region
  cluster_name             = module.eks.cluster_name
  namespace                = var.monitoring_namespace
  chart_version            = var.monitoring_chart_version
  grafana_admin_password   = var.grafana_admin_password
}
