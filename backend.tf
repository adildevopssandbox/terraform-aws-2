# this is a terraform backend aws config
terraform {
  backend "s3" {
    bucket         = "terraformin-backend-aa"
    key            = "teraform/state"
    region         = "us-east-1"
  }
}