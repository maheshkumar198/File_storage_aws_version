terraform {

  required_version = ">= 1.5.0, < 2.0"
 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.43"
    }

     tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
  }
}

# =========================================
# AWS Provider
# =========================================

provider "aws" {
  region = "ap-south-1"
}

# =========================================
# EKS Auth Data
# =========================================

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

# =========================================
# Kubernetes Provider
# =========================================

provider "kubernetes" {

  host = module.eks.cluster_endpoint

  cluster_ca_certificate = base64decode(
    module.eks.cluster_ca_certificate
  )

  token = data.aws_eks_cluster_auth.cluster.token
}

# =========================================
# Helm Provider
# =========================================

provider "helm" {

  kubernetes {

    host = module.eks.cluster_endpoint

    cluster_ca_certificate = base64decode(module.eks.cluster_ca_certificate)

    token = data.aws_eks_cluster_auth.cluster.token
  }
}
