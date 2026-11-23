
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "tfstate-273422285435-eu-north-1"
    key          = "itlui/github-oidc/terraform.tfstate"
    region       = "eu-north-1"
    profile      = "terraform-lab"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region  = "eu-north-1"
  profile = "terraform-lab"
}
