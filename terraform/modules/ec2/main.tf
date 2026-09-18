resource "aws_instance" "this" {
  count = length(var.public_subnet_ids)

  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id = var.public_subnet_ids[count.index]

  vpc_security_group_ids = [
    var.security_group_id
  ]

  iam_instance_profile = var.iam_instance_profile

  tags = {
    Name = "${var.project_name}-ec2-${count.index + 1}"
  }
}