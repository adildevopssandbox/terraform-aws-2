# this is a terraform backend aws config
terraform {
  backend "s3" {
    bucket         = var.back_bucket
    key            = var.back_key
    region         = var.aws_region
  }
}