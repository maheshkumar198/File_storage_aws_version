provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "../../modules/vpc"

  project_name = "devops-project"

  vpc_cidr = "10.0.0.0/16"

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b",
    "ap-south-1c"
  ]
}

module "security_group" {
  source = "../../modules/security-group"

  project_name = "devops-project"
  vpc_id = module.vpc.vpc_id

}

module "iam" {
  source = "../../modules/iam"
  
  project_name = "devops-project"
}

module "s3" {
  source = "../../modules/s3"

  project_name = "mahesh-devops"

  environment = "prod"
}

module "rds" {
  source = "../../modules/rds"

  project_name = "mahesh-devops"

  db_name     = "appdb"
  db_username = "postgres"
  db_password = "Password123!"

  db_subnet_ids = module.vpc.public_subnet_ids

  rds_sg_id = module.security_group.rds_sg_id
}

module "ec2" {
  source = "../../modules/ec2"

  project_name = "mahesh-devops"

  instance_type = "t3.micro"

  public_subnet_ids = module.vpc.public_subnet_ids

  ec2_sg_id = module.security_group.ec2_sg_id

  instance_profile_name = module.iam.instance_profile_name

  target_group_arn = module.alb.target_group_arn

  key_name = "My_Dell_Key"

  ami = "ami-0f58b397bc5c1f2e8"
}

module "alb" {
  source = "../../modules/alb"

  project_name = "mahesh-devops"

  vpc_id = module.vpc.vpc_id

  public_subnet_ids = module.vpc.public_subnet_ids

  alb_sg_id = module.security_group.alb_sg_id
}
