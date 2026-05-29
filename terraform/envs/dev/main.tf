module "vpc" {
  source = "../../modules/vpc"

  project_name = "file-storage"

  environment = "dev"

  cluster_name = "gitops-eks"

  vpc_cidr = "10.0.0.0/16"


  availability_zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}


module "eks" {
  source = "../../modules/eks"

  cluster_name = "gitops-eks"

  cluster_version = "1.33"

  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids

  node_instance_type = "t3.small"

  desired_size = 2
  min_size     = 1
  max_size     = 3
}


module "alb_controller" {

  source = "../../modules/alb-controller"

  cluster_name = module.eks.cluster_name

  oidc_provider_arn = module.eks.oidc_provider_arn

  oidc_provider_url = module.eks.oidc_provider_url

  vpc_id = module.vpc.vpc_id

  region = "ap-south-1"
}



module "rds" {
  source = "../../modules/rds"

  project_name = "file-storage"
  environment  = "dev"
  instance_class = "db.t4g.micro"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
  username = "dbadmin"
  aws_db_secret_name = "filestorage-db-secret"
  db_name =  "filestorage_db"
  allowed_cidr_blocks = ["0.0.0.0/0"]

}

module "backend_ecr" {

  source = "../../modules/ecr"

  repository_name = "file-storage-backend"
}

module "frontend_ecr" {

  source = "../../modules/ecr"

  repository_name = "file-storage-frontend"
}

module "redis" {

  source = "../../modules/redis"

  project_name = "file-storage"

  private_subnet_ids = module.vpc.private_subnet_ids

  vpc_id = module.vpc.vpc_id
}

output "redis_endpoint" {
  value = module.redis.redis_endpoint
}

module "eso" {

  source = "../../modules/eso"

  cluster_name = module.eks.cluster_name
  
  region = "ap-south-1"

  oidc_provider_arn = module.eks.oidc_provider_arn

  oidc_provider_url = module.eks.oidc_provider_url
}


module "frontend_hosting" {
  source = "../../modules/frontend-hosting"

  project_name = "file-storage"
  environment  = "dev"

  bucket_name = "file-storage-dev-frontend"

  domain_name        = "maheshmaharana.online"
  acm_certificate_arn = "arn:aws:acm:us-east-1:905179308072:certificate/a6fa47b9-7e1b-4284-8a75-d51a1758a9e2"

  tags = {
    Terraform = "true"
  }
}

module "argocd" {
  source = "../../modules/argocd"
}

module "backend_irsa" {

  source = "../../modules/irsa"

  namespace            = "backend"
  service_account_name = "backend-sa"

  role_name = "backend-role"

  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url

  policy_json = jsonencode({

    Version = "2012-10-17"

    Statement = [

      # S3
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]

        Resource = [
          "arn:aws:s3:::maheshkumar1981/*"
        ]
      },

      {
        Effect = "Allow"

        Action = [
          "s3:ListBucket"
        ]

        Resource = [
          "arn:aws:s3:::maheshkumar1981"
        ]
      },

      # RDS IAM Authentication
      {
        Effect = "Allow"

        Action = [
          "rds-db:connect"
        ]

        Resource = [
          "*"
        ]
      }
    ]
  })
}