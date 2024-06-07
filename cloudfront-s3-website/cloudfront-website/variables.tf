variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Project name for all resources"
}

variable "zone_id" {
  type        = string
  description = "Route53 zone ID"
}

variable "domain_name" {
  type        = string
  description = "Site domain name, matching client_bucket"
}

variable "alt_domain_name" {
  type        = string
  description = "Alternate CNAME domain name, if any"
  default     = ""
}

variable "certificate_arn" {
  type        = string
  description = "Certificate ARN in ACM"
}

variable "logs_bucket" {
  type        = string
  description = "Name of the S3 bucket to use to store logs"
  default     = "chrislewis-cloudwatch-logs"
}
