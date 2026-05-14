terraform {
  backend "s3" {
    bucket       = "maheshkasumdasdasdsadasdar198asdasdasdasdasdasdasdasdtf"
    key          = "dev/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}

 