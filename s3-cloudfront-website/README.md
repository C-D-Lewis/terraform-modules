# s3-cloudfront-website

Terraform module to create resources for an S3 bucket website behind a
CloudFront distribution.

Resources created:

* `aws_route53_record`
* `aws_s3_bucket`, with policy, ACL, and website configuration
* `aws_cloudfront_distribution`

## Variables

* `region` - AWS region
* `project_name` - Project name for all resources
* `zone_id` - Route53 zone ID
* `domain_name` - Site domain name, matching client_bucket
* `alt_domain_name` - Alternate CNAME domain name, if any (optional)
* `certificate_arn` - Certificate ARN in ACM
* `logs_bucket` - Existing S3 bucket name to store logs in

Note: ACM certificate and Route53 zone must already be created.

## Example

```hcl
module "main" {
  source = "github.com/c-d-lewis/terraform-modules//s3-cloudfront-website?ref=master"

  region          = "us-east-1"
  project_name    = "chrislewis.me.uk"
  zone_id         = "Z0364635209V10D6CEGE"
  domain_name     = "chrislewis.me.uk"
  alt_domain_name = "www.chrislewis.me.uk"
  certificate_arn = "arn:aws:acm:us-east-1:617912924158:certificate/72e3a39b-e701-4269-b429-af2a6a1432b9"
  logs_bucket     = "chrislewis-cloudwatch-logs"
}
```
