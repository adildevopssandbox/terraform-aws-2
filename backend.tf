# this is a terraform backend aws config
terraform {
  backend "s3-bucket" {
    bucket         = var.back-bucket
    key            = var.back-key
    region         = var.aws_region
  }
}