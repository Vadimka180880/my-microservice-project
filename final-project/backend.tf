terraform {
  backend "s3" {
    bucket         = "vadimka180880-lesson89-tfstate-usw2"
    key            = "final-project/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
