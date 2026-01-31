terraform {
  required_version = "~> 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.31.0"
    }
  }

  backend "s3" {
    bucket = "chrislewis-tfstate"
    key    = "terraform-s3-cloudfront-website-test"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "test" {
  source = "../"

  region          = "us-east-1"
  project_name    = "chrislewis.me.uk"
  zone_id         = "Z05682866H59A0KFT8S"
  domain_name     = "module-test.chrislewis.me.uk"
  certificate_arn = "arn:aws:acm:us-east-1:617929423658:certificate/a69e6906-579e-431d-9e4c-707877d325b7"
}

output "website_domain_name" {
  value = module.test.website_domain_name
}
