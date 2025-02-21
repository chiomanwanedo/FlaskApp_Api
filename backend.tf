terraform {
  backend "s3" {
    bucket         = "projectcaddbucket" # Replace with your S3 bucket name
    key            = "devops-pipeline/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "terraform-lock-table" # For state locking
  }
}
