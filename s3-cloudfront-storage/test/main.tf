terraform {
  required_version = "= 1.2.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.31.0"
    }
  }

  backend "s3" {
    bucket = "chrislewis-tfstate"
    key    = "terraform-s3-cloudfront-storage-test"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "test" {
  source = "../"

  region = "us-east-1"
  bucket_name = "terraform-s3-cloudfront-storage-test"
}

output "storage_distribution_domain" {
  value = module.test.storage_distribution_domain
}
