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
    key    = "terraform-ecs-fargate-service-test"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "test" {
  source = "../"

  region              = "us-east-1"
  service_name        = "test-service"
  container_cpu       = 512
  container_memory    = 1024
  port                = 8080
  vpc_id              = "vpc-c3b70bb9"
  certificate_arn     = "arn:aws:acm:us-east-1:617929423658:certificate/a69e6906-579e-431d-9e4c-707877d325b7"
  route53_zone_id     = "Z05682866H59A0KFT8S"
  route53_domain_name = "chrislewis.me.uk"
  create_efs          = true
  health_check_port   = 80
}

output "service_dns" {
  value       = module.test.service_dns
  description = "DNS record for the ECS service"
}

output "ecr_name" {
  value       = module.test.ecr_name
  description = "ECR repository name for the ECS service"
}

output "ecr_uri" {
  value       = module.test.ecr_uri
  description = "ECR repository URI for the ECS service"
}
