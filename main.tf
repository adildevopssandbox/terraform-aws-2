# network config 
resource "aws-vpc" "main-vpc" {
  cidr_block = "10.0.0/16"
}

resource "aws-subnet" "subnet-a" {
  vpc_id = aws_vpc,main-vpc.id
  cidr_block = "10.0.0/24"
  availability_zone = var.aws_availability_zone
}
