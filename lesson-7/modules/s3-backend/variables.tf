variable "bucket_name" {
  type        = string
  description = "S3 bucket name for Terraform state (must be globally unique)"
}

variable "table_name" {
  type        = string
  description = "DynamoDB table name for state locking"
}
