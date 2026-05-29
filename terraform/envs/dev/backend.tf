terraform {
  backend "s3" {
    bucket       = "maheshkumarterraform"
    key          = "dev/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}

 