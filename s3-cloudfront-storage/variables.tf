variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "bucket_name" {
  type        = string
  description = "Site domain name, matching storage_bucket"
}

variable "cache_forever" {
  type        = bool
  description = "Cache files forever"
  default     = false
}
