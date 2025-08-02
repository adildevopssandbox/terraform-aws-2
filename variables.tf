# provider ---------------------
variable "aws_region" {
  description = "The aws region to deploy resources in"
  type    = string
  default = "us-east-1"
}

variable "aws_availability_zone" {
  description = "The availability zone to deploy resources in"
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# backend --------------------
variable "back_bucket" {
  description = "The S3 bucket for teraform backend state file"
  type    = string
  default = "terraformin-backend-aa"
}
variable "back_key" {
  description = "The key for the Terraform state in the S3 bucket"
  type    = string
  default = "terraform/state"
}

# network --------------------
variable "vpc_name" {
  description = "name tag for the vpc"
  type    = string
  default = "main-vpc"
}

variable "subnet_name" {
  description = "name tag for the subnet"
  type    = string
  default = "sub-a"
}

# storage -----------------------
variable "s3_bucket_name" {
  type = string
 
}

variable "cidr_sg" {
  description = "custom ip value for security group"
  type = string
  default = "23.234.114.110/32"
}

# compute ------------------------
variable "ami" {
  description = "this is for amazon linux ami 2023"
  type = string
  default = "al2023-ami-*-x86_64"
}
variable "instance_type" {
  description = "default instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "name tag for the ec2 instance"
  type = string
  default = "ec2-1"
}

variable "db_username" {
  description = "username for rds db"
  type = string
  default = "admin"
}

variable "db_password" {
  description = "password to db_username"
  type = string
  default = ""
}

variable "rds_subnet_group_name" {
  description = "name for rds subnet group"
  type = string
  default = "rds-subnet-group"
}
