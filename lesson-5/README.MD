# Lesson 5 — Terraform IaC (AWS)

## Project structure
lesson-5/
- main.tf
- backend.tf
- variables.tf
- outputs.tf
- terraform.tfvars (local only)
- modules/
  - s3-backend/
  - vpc/
  - ecr/

## Modules
### s3-backend
Creates S3 bucket for Terraform state and DynamoDB table for state locking.

### vpc
Creates VPC with 3 public and 3 private subnets, Internet Gateway, NAT Gateway, and route tables.

### ecr
Creates ECR repository with image scan on push and repository policy.

## Commands
Initialize:
terraform init

Plan:
terraform plan

Apply:
terraform apply

Destroy:
terraform destroy