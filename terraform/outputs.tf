output "vpc_id" {
  value = aws_vpc.main.id
}

output "rds_endpoint" {
  value = aws_db_instance.mysql.address
}

output "rds_port" {
  value = aws_db_instance.mysql.port
}

output "s3_bucket_name" {
  value = aws_s3_bucket.employee_images.bucket
}

output "ec2_public_ip" {
  value = aws_instance.app.public_ip
}