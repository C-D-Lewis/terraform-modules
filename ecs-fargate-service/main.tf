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

output "service_dns" {
  value = aws_route53_record.server_record.fqdn
  description = "DNS record for the ECS service"
}

output "ecr_name" {
  value = aws_ecr_repository.repository.name
  description = "ECR repository name for the ECS service"
}

output "ecr_uri" {
  value = aws_ecr_repository.repository.repository_url
  description = "ECR repository URI for the ECS service"
}
