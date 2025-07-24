# cloudfront-s3-storage

Terraform module to create resources for a public S3 bucket behind a CloudFront
distribution.

Resources created:

* `aws_s3_bucket`, with policy and ACL
* `aws_cloudfront_distribution`

## Variables

* `region` - AWS region
* `bucket_name` - Bucket name to use
* `cache_forever` - Cache files forever.

## Outputs

* `storage_distribution_domain` - Domain of the storage.

## Example

```hcl
module "main" {
  source = "github.com/c-d-lewis/terraform-modules//s3-cloudfront-storage?ref=master"

  region          = "us-east-1"
  bucket_name    = "chrislewis.me.uk-assets"
}
```
