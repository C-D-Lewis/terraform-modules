locals {
  origin_id = "${var.project_name}-Origin"
}

resource "aws_cloudfront_distribution" "client_distribution" {
  aliases             = compact([var.domain_name, var.alt_domain_name])
  price_class         = "PriceClass_100"
  enabled             = true
  default_root_object = var.default_root_object

  origin {
    domain_name = aws_s3_bucket.client_bucket.bucket_regional_domain_name
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

  dynamic "logging_config" {
    for_each = var.logs_bucket != "" ? [1] : []
    content {
      include_cookies = false
      bucket          = "${var.logs_bucket}.s3.amazonaws.com"
      prefix          = var.domain_name
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.certificate_arn
    ssl_support_method  = "sni-only"
  }
}
