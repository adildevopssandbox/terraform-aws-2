# network -------------------------
output "vpc_id" {
    description = "id of created vpc"
    value = aws_vpc.main_vpc.id
}

output "ec2_public_ip" {
  description = "public ip of the ec2 instance"
  value       = aws_instance.ec2.public_ip
}

# storag ---------------------------
output "s3_bucket_name" {
  description = "The name of the private S3 bucket"
  value       = aws_s3_bucket.static_site.id
}

