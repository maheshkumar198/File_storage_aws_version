# =========================================
# EKS Cluster
# =========================================

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn

  version = var.cluster_version

  vpc_config {
    subnet_ids = concat(
    var.private_subnet_ids,
    var.public_subnet_ids
  )

    endpoint_private_access = true
    endpoint_public_access  = true

    public_access_cidrs = ["0.0.0.0/0"]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}

# =========================================
# OIDC Provider (IRSA)
# =========================================

data "tls_certificate" "this" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "this" {
  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.this.certificates[0].sha1_fingerprint
  ]

  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the EKS cluster VPC configuration."
  type        = list(string)
  default     = []
}
