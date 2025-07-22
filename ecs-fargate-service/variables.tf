variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "service_name" {
  type        = string
  description = "Name of the ECS service"
}

variable "container_cpu" {
  type        = number
  description = "CPU units for the Fargate task"
  default     = 512
}

variable "container_memory" {
  type        = number
  description = "Memory in MiB for the Fargate task"
  default     = 1024
}

variable "port" {
  type        = number
  description = "Port on which the service will listen"
  default     = 8000
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the ECS service will run"
}

variable "certificate_arn" {
  type        = string
  description = "ARN of the SSL certificate for the ALB"
}

variable "route53_zone_id" {
  type        = string
  description = "Route53 zone ID for DNS records"
}

variable "route53_domain_name" {
  type        = string
  description = "Domain name for the Route53 record"
}
