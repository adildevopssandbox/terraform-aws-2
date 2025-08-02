# this is a terraform backend aws config
terraform {
  backend "s3" {
    bucket         = "terraform-backend-aa1"
    key            = "teraform/state"
    region         = "us-east-1"
  }
}