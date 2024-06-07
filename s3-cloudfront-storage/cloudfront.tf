locals {
  origin_id = "${var.bucket_name}-Origin"
}

resource "aws_cloudfront_distribution" "storage_distribution" {
  price_class         = "PriceClass_100"
  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.storage_bucket.bucket_regional_domain_name
    origin_id   = local.origin_id
  }

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = local.origin_id
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    ssl_support_method  = "sni-only"
  }
}