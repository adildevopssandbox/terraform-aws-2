# provider
variable "aws_region" {
  description = "The aws region to deploy resources in"
  type        = string
  default     = "" # i hear leaving this empty will make you chose the region.
}

# backend
variable "back-bucket" {
  description = "The S3 bucket for Terraform state"
  type        = string
  default     = "-- IGNORE ---" # makeyourbucket
}
variable "back-key" {
  description = "The key for the Terraform state in the S3 bucket"
  type        = string
  default     = "terraform/state"
}

# network
variable "vpc_id" {
  description = "-- IGNORE ---" # leave empty to use the default VPC
  type        = string
  default     = "" # leave empty to use the default VPC
}











#ignore everything below this line, work in progress
variable "create_vpc" {
  type    = bool
  default = false
}

resource "aws_vpc" "main" {
  count             = var.create_vpc ? 1 : 0
  cidr_block        = "10.0.0.0/16"
  enable_dns_hostnames = true
}

data "aws_vpc" "existing" {
  count = var.create_vpc ? 0 : 1
  filter {
    name   = "tag:Name"
    values = ["your-vpc-name"]
  }
}

# Use the correct VPC ID
locals {
  vpc_id = var.create_vpc ? aws_vpc.main[0].id : data.aws_vpc.existing[0].id
}
