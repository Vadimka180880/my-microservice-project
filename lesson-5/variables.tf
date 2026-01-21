variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-west-2"
}

variable "tf_state_bucket" {
  type        = string
  description = "S3 bucket for Terraform state (must be globally unique)"
}

variable "tf_lock_table" {
  type        = string
  description = "DynamoDB table for state locking"
  default     = "terraform-locks"
}
