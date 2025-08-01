# provider
variable "aws-region" {
  description = "The aws region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "aws-availability-zone" {
  description = "The availability zone to deploy resources in"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# backend
variable "back-bucket" {
  description = "The S3 bucket for teraform backend state file"
  type        = string
  default     = "terraformin-backend-aa"
}
variable "back-key" {
  description = "The key for the Terraform state in the S3 bucket"
  type        = string
  default     = "terraform/state"
}

# network
variable "vpc-id" {
  description = "-- IGNORE ---" # leave empty to use the default VPC
  type        = string
  default     = "" # leave empty to use the default VPC
}