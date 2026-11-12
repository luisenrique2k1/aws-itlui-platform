
# Default AWS provider — Stockholm
provider "aws" {
  region  = "eu-north-1"
  profile = "terraform-lab"

  default_tags {
    tags = {
      Project     = "ITLUI"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}

# Additional AWS provider — N. Virginia
# Required for CloudFront ACM certificates
provider "aws" {
  alias   = "us_east_1"
  region  = "us-east-1"
  profile = "terraform-lab"

  default_tags {
    tags = {
      Project     = "ITLUI"
      Environment = "dev"
      ManagedBy   = "Terraform"
    }
  }
}
