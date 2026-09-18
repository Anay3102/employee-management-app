resource "aws_db_subnet_group" "this" {
  name = "${var.project_name}-db-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier = "${var.project_name}-mysql"

  engine = "mysql"

  instance_class = var.db_instance_class

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [
    var.security_group_id
  ]

  publicly_accessible = false

  backup_retention_period = 7

  skip_final_snapshot = true

  tags = {
    Name = "${var.project_name}-mysql"
  }
}