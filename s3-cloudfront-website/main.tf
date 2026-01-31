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

output "website_domain_name" {
  value = aws_cloudfront_distribution.client_distribution.domain_name
}
