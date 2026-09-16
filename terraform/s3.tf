resource "aws_s3_bucket" "employee_images" {
  bucket = "${var.project_name}-employee-images"

  tags = {
    Name = "${var.project_name}-employee-images"
  }
}