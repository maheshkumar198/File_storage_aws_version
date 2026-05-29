resource "helm_release" "argocd" {

  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"

  namespace        = var.namespace
  create_namespace = true

  timeout = 600

  set {
    name  = "server.service.type"
    value = "ClusterIP"
  }
}

