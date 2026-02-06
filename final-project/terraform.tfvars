aws_region = "us-west-2"

azs = ["us-west-2a","us-west-2b","us-west-2c"]

vpc_name = "final-project-vpc"
vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs  = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
private_subnet_cidrs = ["10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]

ecr_repository_name = "final-project-ecr"
eks_cluster_name    = "final-project-eks"

# Cost-saving: scale node group to 0 when idle
eks_node_desired_size = 0
eks_node_min_size     = 0
eks_node_max_size     = 0

tf_lock_table_name   = "terraform-locks"
tf_state_bucket_name = "vadimka180880-lesson89-tfstate-usw2"

jenkins_admin_user     = "admin"
jenkins_admin_password = "change-me"

argo_cd_repo_url      = "https://github.com/Vadimka180880/my-microservice-project.git"
argo_cd_app_path      = "final-project/charts/django-app"
argo_cd_app_revision  = "final-project"

ebs_csi_role_arn = "arn:aws:iam::804219314385:role/AmazonEKS_EBS_CSI_DriverRole_8_9"

# RDS/Aurora
rds_name_prefix                = "app"
rds_use_aurora                 = false
rds_engine                     = "postgres"
rds_engine_version             = "15.5"
rds_instance_class             = "db.t3.micro"
rds_multi_az                   = false
rds_allocated_storage          = 20
rds_storage_type               = "gp3"
rds_db_name                    = "appdb"
rds_username                   = "appuser"
rds_password                   = "change-me"
rds_allowed_cidr_blocks        = ["10.0.0.0/16"]
rds_parameter_group_family     = "postgres15"
rds_aurora_parameter_group_family = "aurora-postgresql15"
rds_backup_retention_period    = 7
rds_skip_final_snapshot        = true
rds_deletion_protection        = false
rds_publicly_accessible        = false
rds_aurora_instance_count      = 1
rds_apply_immediately          = true

# Monitoring
grafana_admin_password = "change-me"
