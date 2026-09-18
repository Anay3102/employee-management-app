module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  db_subnet_cidrs      = var.db_subnet_cidrs
}

module "security" {
  source = "./modules/security"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
}

module "ec2" {
  source = "./modules/ec2"

  project_name = var.project_name
  ami_id       = var.ami_id

  instance_type = var.instance_type

  public_subnet_ids = module.vpc.public_subnet_ids

  security_group_id = module.security.ec2_security_group_id

  iam_instance_profile = module.iam.ec2_instance_profile_name
}

module "rds" {
  source = "./modules/rds"

  project_name = var.project_name

  private_subnet_ids = module.vpc.db_subnet_ids

  security_group_id = module.security.rds_security_group_id

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  db_instance_class = var.db_instance_class
}

module "s3" {
  source = "./modules/s3"

  project_name = var.project_name
}