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
  default = "1.34"
}

variable "eks_node_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}
