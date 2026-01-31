terraform {
  required_version = "~> 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.31.0"
    }
  }
}

provider "aws" {
  region = var.region
}

output "storage_distribution_domain" {
  value = aws_cloudfront_distribution.storage_distribution.domain_name
}
