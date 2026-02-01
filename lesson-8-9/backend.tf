terraform {
  backend "s3" {
    bucket         = "vadimka180880-lesson89-tfstate-usw2"
    key            = "lesson-8-9/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
