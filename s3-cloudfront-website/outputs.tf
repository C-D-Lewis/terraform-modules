output "distribution_id" {
  description = "ID of the CloudFront distribution created"
  value = aws_cloudfront_distribution.client_distribution.id
}
