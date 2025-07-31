# vpc
data "aws_vpc" "default-vpc" {
  region = var.aws_region
  }

