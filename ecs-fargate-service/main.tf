terraform {
  required_version = "= 1.2.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.31.0"
    }
  }
}

provider "aws" {
  region = var.region
}

// Output service DNS record
output "service_dns" {
  value = aws_route53_record.server_record.fqdn
  description = "DNS record for the ECS service"
}
