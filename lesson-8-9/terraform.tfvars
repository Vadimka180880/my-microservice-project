aws_region = "us-west-2"

azs = ["us-west-2a","us-west-2b","us-west-2c"]

vpc_name = "lesson-8-9-vpc"
vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs  = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
private_subnet_cidrs = ["10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]

ecr_repository_name = "lesson-8-9-ecr"
eks_cluster_name    = "lesson-8-9-eks"

tf_lock_table_name   = "terraform-locks"
tf_state_bucket_name = "vadimka180880-lesson89-tfstate-usw2"

jenkins_admin_user     = "admin"
jenkins_admin_password = "change-me"

argo_cd_repo_url = "https://github.com/Vadimka180880/my-microservice-project.git"
argo_cd_app_path = "lesson-7/charts/django-app"
