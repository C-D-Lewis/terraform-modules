terraform {
  required_version = "~> 1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.35.0"
    }
  }
}

provider "aws" {
  region = var.region
}

output "storage_distribution_domain" {
  value = aws_cloudfront_distribution.storage_distribution.domain_name
}
