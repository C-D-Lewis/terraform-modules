resource "aws_route53_record" "server_record" {
  zone_id = var.route53_zone_id
  name    = "${var.service_name}-api.${var.route53_domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = false
  }
}
