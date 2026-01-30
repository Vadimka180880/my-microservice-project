terraform {
  backend "s3" {
    bucket         = "vadimka180880-lesson7-tfstate-usw2"
    key            = "lesson-7/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
