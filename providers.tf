# version
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# aws config
provider "aws" {
  region = var.aws_region
  #access_key = "--- IGNORE ---"
  #secret_key = "--- IGNORE ---"
}

