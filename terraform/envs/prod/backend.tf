terraform {
  backend "s3" {
    bucket       = "maheshkuasdasdasdasdasdasmar198tf"
    key          = "prod/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}

 