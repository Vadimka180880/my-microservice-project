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
  source          = "./modules/ecr"
  ecr_name = var.ecr_repository_name
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_cluster_version

  # важливо: беремо підмережі з VPC-модуля
  subnet_ids = module.vpc.private_subnet_ids

  node_instance_types = var.eks_node_instance_types
  node_desired_size   = 2
  node_min_size       = 2
  node_max_size       = 6
}
