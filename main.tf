# network config ---------------------------
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0/16"
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.0/24"
  availability_zone = var.aws_availability_zone[0]
  tags = {
    Name = var.subnet_name
  }
}

# storage buckets ---------------------
resource "aws_s3_bucket" "static_site" {
  bucket = var.s3_bucket_name
  tags   = {
    Name = "private-bucket"
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.static_site.id
  versioning_configuration {
    status = "Enabled"
  }
}

# ec2 security group
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "allows ssh for ec2"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_sg]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}

# rds security group
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow PostgreSQL from EC2"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description            = "postgresql access from ec2"
    from_port              = 5432
    to_port                = 5432
    protocol               = "tcp"
    security_groups        = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

# compute ----------------------------
#     ec2 ----------------------------
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

resource "aws_instance" "ec2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet_a

  tags = {
    Name = var.instance_name
  }
}

#       rds ---------------------------
resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "postgres"
  engine_version       = "15.4"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet.name
  parameter_group_name = "default.postgres15"
  skip_final_snapshot  = true
  tags                 = {
    Name = "postgres-rds"
  } 
}

resource "aws_db_subnet_group" "rds_subnet" {
  name       = var.rds_subnet_group_name
  subnet_ids = [aws_subnet.subnet_a.id]
}

